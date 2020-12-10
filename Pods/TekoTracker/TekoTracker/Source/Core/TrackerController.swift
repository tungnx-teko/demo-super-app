//
//  TrackerController.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import RxSwift
import Alamofire

protocol TrackerControllerProtocol {
    func use(userID: String, phoneNumber: String?)
    func send(_ params: [EventParameter], isImmediate: Bool)
    func send(_ params: EventParameter, isImmediate: Bool)
    func logDidEndLoadingTime()

    func start()
    func pause()
    func stop()
}

@objc(ObjcTrackerController)
final class TrackerController: NSObject {
    let config: TrackerConfigurable
    private let context: TrackerContextProtocol
    let request: TrackerRequestProtocol
    private let store: EventDataStoreProtocol?
    private var sendEventBlockDisposable: Disposable?
    private var isStarted: Bool = false
    var variableStore: VariableStoreProtocol

    var currentSession: Session

    let uiKitInjector: UIKitInjector
    let requestInjector: URLSessionInjector

    var scrollViewVelocityDict: [Int: CGPoint]
    private var readyEventCountInTimingWindow = 0 {
        didSet {
            trySendingEventBlockIfReadyEventCountExceedsThreshold()
        }
    }
    private var isSendingBlock = false
    private var refreshSessionTimer: Timer?

    deinit {
        sendEventBlockDisposable?.dispose()
    }

    convenience init(config: TrackerConfigurable) {
        let store: EventDataStore?
        do {
            store = try EventDataStore(logDebug: config.logDebug)
        } catch {
            #if !RELEASE || !PRODUCTION
            if config.logDebug {
                print("TekoTracker => Failed to initialize store", error as NSError)
            }
            #endif
            store = nil
        }
        let requestEnvironment = TrackerEnviroment(baseURL: URL(string: config.logServerURL)!)
        let context = TrackerContext(appID: config.appID)
        self.init(config: config,
                  context: context,
                  request: TrackerRequest(
                    environment: requestEnvironment,
                    retryTimes: Int(config.retryWhenFailed),
                    logDebug: config.logDebug),
                  store: store,
                  variableStore: VariableStore())
        context.delegate = self
    }

    /// Unit testing
    init(config: TrackerConfigurable,
         context: TrackerContextProtocol,
         request: TrackerRequestProtocol,
         store: EventDataStoreProtocol?,
         variableStore: VariableStoreProtocol) {
        self.config = config
        self.variableStore = variableStore
        self.store = store
        self.context = context
        self.request = request
        self.currentSession = context.generateSession()
        self.scrollViewVelocityDict = [:]
        self.uiKitInjector = UIKitInjector()
        self.requestInjector = URLSessionInjector()
        super.init()
        self.uiKitInjector.delegate = self
        self.requestInjector.delegate = self
    }

    func setTimerToRefreshSession() {
        if let timer = refreshSessionTimer {
            if timer.isValid { return }
            setTimerToRefreshSessionIfNeeded()
        } else {
            setTimerToRefreshSessionIfNeeded()
        }
    }

    private func setTimerToRefreshSessionIfNeeded() {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 7 * 3600)! // ICT
        let startOfDate = calendar.startOfDay(for: Date().addingTimeInterval(variableStore.distanceToServerTime))
        let startOfNextDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!

        self.refreshSessionTimer?.invalidate()
        let timer = Timer(fireAt: startOfNextDate, interval: 0, target: self, selector: #selector(scheduleToRefreshSession), userInfo: nil, repeats: false)
        self.refreshSessionTimer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    @objc func scheduleToRefreshSession() {
        if let lastScreenInfo = variableStore.lastScreenInfo, lastScreenInfo.isConfirmed {
            sendExitScreenViewEvent(currentScreenInfo: lastScreenInfo)
        }
        currentSession = context.generateSession()
        if let lastScreenInfo = variableStore.lastScreenInfo, lastScreenInfo.isConfirmed {
            lastScreenInfo.viewID = UUID().uuidString
            sendEnterScreenViewEvent(currentScreenInfo: lastScreenInfo, lastScreenInfo: lastScreenInfo)
        }
        setTimerToRefreshSession()
    }

    func refreshSession() {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 7 * 3600)! // ICT
        let sessionCreatedDate = Date(timeIntervalSince1970: currentSession.createdAt)
        let startOfDate = calendar.startOfDay(for: Date().addingTimeInterval(variableStore.distanceToServerTime))
        switch startOfDate.compare(sessionCreatedDate) {
        case .orderedDescending, .orderedSame:
            if let lastScreenInfo = variableStore.lastScreenInfo, lastScreenInfo.isConfirmed {
                sendExitScreenViewEvent(currentScreenInfo: lastScreenInfo)
            }
            currentSession = context.generateSession()
            if let lastScreenInfo = variableStore.lastScreenInfo, lastScreenInfo.isConfirmed {
                lastScreenInfo.viewID = UUID().uuidString
                sendEnterScreenViewEvent(currentScreenInfo: lastScreenInfo, lastScreenInfo: lastScreenInfo)
            }
        case .orderedAscending:
            break
        }
    }
}

extension TrackerController: TrackerControllerProtocol {
    func use(userID: String, phoneNumber: String?) {
        context.use(userID: userID, phoneNumber: phoneNumber)
    }

    func send(_ params: [EventParameter], isImmediate: Bool) {
        if params.isEmpty {
            return
        }
        do {
            let events = try params.map(buildEvent(from:))
            if isImmediate {
                sendGroupImmediately(events: events)
            } else {
                sendGroup(events: events)
            }
        } catch {
            #if !RELEASE || !PRODUCTION
            if config.logDebug {
                print("TekoTracker => Event Initialization", error as NSError)
            }
            #endif
        }
    }

    func send(_ params: EventParameter, isImmediate: Bool) {
        do {
            let event = try buildEvent(from: params)
            if isImmediate {
                sendImmediately(event: event)
            } else {
                send(event: event)
            }
        } catch {
            #if !RELEASE || !PRODUCTION
            if config.logDebug {
                print("TekoTracker => Event Initialization", error as NSError)
            }
            #endif
        }
    }

    func logDidEndLoadingTime() {
        guard let currentScreenInfo = variableStore.lastScreenInfo, currentScreenInfo.shouldHoldToTrackOnLoad else { return }
        currentScreenInfo.loadEventEnd = Date().timeIntervalSince1970 + variableStore.distanceToServerTime
        sendPendingEnterScreenViewEvent()
    }

    func start() {
        variableStore.retrieve()
        scheduleSendEventRequestBlock()
        context.startListener()
        isStarted = true
        setTimerToRefreshSession()
        refreshSession()
    }

    func pause() {
        isStarted = false
        refreshSessionTimer?.invalidate()
        refreshSessionTimer = nil
        context.stopListener()
        variableStore.commit()
    }

    func stop() {
        isStarted = false
        refreshSessionTimer?.invalidate()
        refreshSessionTimer = nil
        context.stopListener()
        sendEventBlockDisposable?.dispose()
        sendEventBlockDisposable = nil
        variableStore.clean()
    }
}

// MARK: - Schedule to send
extension TrackerController {
    func send(event: Event) {
        _ = Observable
            .just(event)
            .map(toEventRequestModel)
            // Save to db
            .do(onNext: saveReadyEventRequestModelIgnoreFailure(_:))
            // Update if successed
            .subscribe(onNext: {
                [weak config] event in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Save successfully", event.id)
                }
                #endif
            }, onError: {
                [weak config] error in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Failed to update", error as NSError)
                }
                #endif
            })
    }

    func sendGroup(events: [Event]) {
        _ = Observable
            .just(events)
            .map(toEventRequestModel)
            // Save to db
            .do(onNext: saveReadyEventRequestModelIgnoreFailure(_:))
            // Update if successed
            .subscribe(onNext: {
                [weak config] event in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Save successfully", event.id)
                }
                #endif
            }, onError: {
                [weak config] error in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Failed to update", error as NSError)
                }
                #endif
            })
    }
}

// MARK: - Send immediately
extension TrackerController {
    func sendImmediately(event: Event) {
        _ = _sendImmediately(event: event)
            .do(onNext: {
                [weak config] id in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Save successfully", id)
                }
                #endif
            }, onError: {
                [weak config] error in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Failed to update", error as NSError)
                }
                #endif
            })
            .map { _ in 1 }
            .catchError ({
                [weak self] error -> Observable<Int> in
                guard let self = self, self.shouldSendEventCountIfOccur(error: error) else { throw error }
                return self.request.sendCount(.init(appID: self.context.appID, count: 1))
                        .map { _ in throw error }
            })
            .flatMap ({
                [weak self] _ -> Observable<Int> in
                guard let self = self else { return .empty() }
                return self.request.sendCount(.init(appID: self.context.appID, count: 1))
            })
            .subscribe()
    }

    func _sendImmediately(event: Event) -> Observable<String> {
        Observable
            .just(event)
            .map(toEventRequestModel)
            // Save to db
            .do(onNext: savePendingEventRequestModelIgnoreFailure)
            // Convert to request model
            .map { SingleEventRequestParam(from: $0, distanceToServerTime: self.variableStore.distanceToServerTime) }
            // Send data to server
            .flatMap ({
                [weak self] param in
                self?.request.send(param)
                    // Update if successed
                    .do(onNext: ({
                        [weak self] id in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(class: SingleEventRequestModel.self, ids: [id], status: .completed)
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Send successfully", id)
                        }
                        #endif
                    }), onError: {
                        [weak self] error in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(
                            class: SingleEventRequestModel.self,
                            ids: [param.originalID],
                            status: self.eventStatus(for: error)
                        )
                    }) ?? .empty()
            })
    }

    func sendGroupImmediately(events: [Event]) {
        if events.isEmpty { return }
        let eventCount = events.count
        _ = _sendGroupImmediately(events: events)
            .do(onNext: {
                [weak config] ids in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Save successfully", ids)
                }
                #endif
            }, onError: {
                [weak config] error in
                #if !RELEASE || !PRODUCTION
                if config?.logDebug ?? false {
                    print("TekoTracker => Failed to update", error as NSError)
                }
                #endif
            })
            .map { _ in eventCount }
            .catchError ({
                [weak self] error -> Observable<Int> in
                guard let self = self, self.shouldSendEventCountIfOccur(error: error) else { throw error }
                return self.request.sendCount(.init(appID: self.context.appID, count: eventCount))
                    .map { _ in throw error }
            })
            .flatMap ({
                [weak self] eventCount -> Observable<Int> in
                guard let self = self else { return .empty() }
                return self.request.sendCount(.init(appID: self.context.appID, count: eventCount))
            })
            .subscribe()
    }

    func _sendGroupImmediately(events: [Event]) -> Observable<String> {
        Observable<[Event]>
            .just(events)
            .map(toEventRequestModel)
            // Save to db
            .do(onNext: savePendingEventRequestModelIgnoreFailure)
            .map { MultiEventRequestParam(from: $0, distanceToServerTime: self.variableStore.distanceToServerTime) }
            .flatMap ({
                [weak self] params in
                self?.request.send(params)
                    .do(onNext: ({
                        [weak self] id in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(class: MultiEventRequestModel.self, ids: [id], status: .completed)
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Send successfully", id)
                        }
                        #endif
                    }), onError: {
                        [weak self] error in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(
                            class: MultiEventRequestModel.self,
                            ids: [params.originalID],
                            status: self.eventStatus(for: error)
                        )
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Failed to send", [params.originalID])
                        }
                        #endif
                    }) ?? .empty()
            })
    }
}

// MARK: - TrackerContextDelegate
extension TrackerController: TrackerContextDelegate {
    func networkDidBecomeReachable(_ context: TrackerContext) {
        syncServerTime()
    }

    func networkDidResignReachable(_ context: TrackerContext) {
        
    }
}

// MARK: - Build an event from parameter
private extension TrackerController {
    func buildEvent(from params: EventParameter) throws -> Event {
        let viewID: String
        let referrerScreenName = variableStore.lastScreenInfo?.name ?? ""
        switch params.eventName {
        case EventName.enterScreenView.value:
            viewID = UUID().uuidString.lowercased()
            guard let eventData = params.data as? ScreenViewEventData else {
                throw Constant.Error.unsupportedEventTypeEventInitialization
            }
            variableStore.popLastScreenInfo()
            variableStore.lastScreenInfo = eventData.toScreenInfo(viewID: viewID, referrer: referrerScreenName)
        default:
            viewID = variableStore.lastScreenInfo?.viewID ?? UUID().uuidString.lowercased()
        }
        let viewIDSetterSelector = Selector(("setViewID:"))
        if params.data.responds(to: viewIDSetterSelector) {
            params.data.perform(viewIDSetterSelector, with: viewID)
        }
        let referrerScreenNameSetterSelector = Selector(("setReferrerScreenName:"))
        let screenNameSetterSelector = Selector(("setScreenName:"))
        if params.data.responds(to: referrerScreenNameSetterSelector) {
            params.data.perform(referrerScreenNameSetterSelector, with: referrerScreenName)
        } else if params.data.responds(to: screenNameSetterSelector) {
            params.data.perform(screenNameSetterSelector, with: referrerScreenName)
        }
        return try Event(
            distanceToServerTime: variableStore.distanceToServerTime,
            eventType: params.eventType,
            schemaName: params.schemaName,
            eventName: params.eventName,
            viewID: viewID,
            data: params.data,
            encode: (params.data as? Encodable)?.encode
        )
    }
}

// MARK: - Produce request model
private extension TrackerController {
    func toEventRequestModel(from event: Event) throws -> SingleEventRequestModel {
        guard let context = self.store?.managedObjectContext else {
            throw Constant.Error.storeInitialization
        }
        return .init(
            event: event,
            appID: self.context.appID,
            schemaVersion: self.config.schemaVersion,
            appVersion: self.context.appVersion ?? "unknown",
            session: self.currentSession,
            visitor: self.context.visitor,
            networkInfo: self.context.currentNetworkConnectionInfo ?? .unknown,
            context: context
        )
    }

    func toEventRequestModel(from events: [Event]) throws -> MultiEventRequestModel {
        guard let context = self.store?.managedObjectContext else {
            throw Constant.Error.storeInitialization
        }
        return .init(
            events: events,
            appID: self.context.appID,
            schemaVersion: self.config.schemaVersion,
            appVersion: self.context.appVersion ?? "unknown",
            session: self.currentSession,
            visitor: self.context.visitor,
            networkInfo: self.context.currentNetworkConnectionInfo ?? .unknown,
            context: context
        )
    }
}

// MARK: - Save event
private extension TrackerController {
    func saveEventRequestModelIgnoreFailure<T>(_ model: T, status: Constant.UploadStatus) where T: BaseRequestModel {
        self.store?.save(model, status: status)
    }

    func savePendingEventRequestModelIgnoreFailure<T>(_ model: T) where T: BaseRequestModel {
        saveEventRequestModelIgnoreFailure(model, status: .processing)
    }

    func saveReadyEventRequestModelIgnoreFailure<T>(_ model: T) where T: BaseRequestModel {
        if variableStore.isValidDistanceToServerTime {
            saveEventRequestModelIgnoreFailure(model, status: .ready)
            readyEventCountInTimingWindow += 1
        } else {
            saveEventRequestModelIgnoreFailure(model, status: .needToSyncTime)
        }
    }

    func eventStatus(for error: Error) -> Constant.UploadStatus {
        guard config.scheduleRetryFailure else { return .never }
        switch error {
        case let e as NSError where e == Constant.Error.invalidViewIDEventEncoding:
            return .never
        case let e as AFError where e.responseCode == 400:
            return .never
        default:
            return .failed
        }
    }

    func shouldSendEventCountIfOccur(error: Error) -> Bool {
        switch error {
        case let e as NSError where e == Constant.Error.invalidViewIDEventEncoding:
            return false
        case let e as AFError:
            if let responseCode = e.responseCode, 500..<599 ~= responseCode {
                return false
            }
            return true
        default:
            return true
        }
    }
}

// MARK: - Schedule to send
private extension TrackerController {
    func scheduleSendEventRequestBlock() {
        if sendEventBlockDisposable != nil { return }
        scheduleSendEventRequestBlockIfNeeded()
    }

    func scheduleSendEventRequestBlockIfNeeded() {
        sendEventBlockDisposable?.dispose()
        sendEventBlockDisposable = Observable<Int>
            .interval(DispatchTimeInterval.seconds(Constant.eventUploadPeriodTimestamp), scheduler: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: {
                [weak self] _ in
                self?.trySendingEventBlock()
            })
    }

    func trySendingEventBlock() {
        let statuses: [Constant.UploadStatus] = config.scheduleRetryFailure ? [.failed, .ready] : [.ready]
        trySendingEventBlock(statuses: statuses)
    }

    func trySendingEventBlock(statuses: [Constant.UploadStatus]) {
        guard !isSendingBlock, let store = self.store else { return }
        isSendingBlock = true

        let singleEventUploading = store.getEventRequests(class: SingleEventRequestModel.self, statuses: statuses, page: 0)
            .do(onNext: {
                [weak self] eventRequests in
                self?.store?.updateUploadStatus(class: SingleEventRequestModel.self, ids: eventRequests.map { $0.id }, status: .processing)
            })
            .map { $0.toSingleEventRequests(distanceToServerTime: self.variableStore.distanceToServerTime) }
            .flatMap ({
                [weak self] eventRequestModels -> Observable<Int> in
                guard let request = self?.request else { return .empty() }
                if eventRequestModels.isEmpty { return .just(0) }
                let eventCount = eventRequestModels.count
                return request.send(eventRequestModels)
                    .do(onNext: ({
                        [weak self] ids in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(class: SingleEventRequestModel.self, ids: ids, status: .completed)
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Send successfully", ids)
                        }
                        #endif
                    }), onError: {
                        [weak self] error in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(
                            class: SingleEventRequestModel.self,
                            ids: eventRequestModels.map { $0.originalID },
                            status: self.eventStatus(for: error)
                        )
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Send failed", error as NSError)
                        }
                        #endif
                    })
                    .map { _ in eventCount }
                    .catchError ({
                        [weak self] error -> Observable<Int> in
                        guard let self = self, self.shouldSendEventCountIfOccur(error: error) else { throw error }
                        return self.request.sendCount(.init(appID: self.context.appID, count: eventCount))
                            .map { _ in throw error }
                    })
            })
            .flatMap({
                [weak self] count -> Observable<Int> in
                guard let self = self else { return .empty() }
                if count == 0 { return .just(0) }
                return self.request.sendCount(EventCountParams(appID: self.context.appID, count: count))
            })

        let multiEventUploading = store.getEventRequests(class: MultiEventRequestModel.self, statuses: statuses, page: 0)
            .do(onNext: {
                [weak self] eventRequests in
                self?.store?.updateUploadStatus(class: MultiEventRequestModel.self, ids: eventRequests.map { $0.id }, status: .processing)
            })
            .map { $0.toSingleEventRequests(distanceToServerTime: self.variableStore.distanceToServerTime) }
            .flatMap ({
                [weak self] eventRequestModels -> Observable<Int> in
                guard let request = self?.request else { return .empty() }
                if eventRequestModels.isEmpty { return .just(0) }
                let eventCount = eventRequestModels.reduce(0) { $0 + $1.events.count }
                return request.send(eventRequestModels)
                    .do(onNext: ({
                        [weak self] ids in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(class: MultiEventRequestModel.self, ids: ids, status: .completed)
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Send successfully", ids)
                        }
                        #endif
                    }), onError: {
                        [weak self] error in
                        guard let self = self else { return }
                        self.store?.updateUploadStatus(
                            class: MultiEventRequestModel.self,
                            ids: eventRequestModels.map { $0.originalID },
                            status: self.eventStatus(for: error)
                        )
                        #if !RELEASE || !PRODUCTION
                        if self.config.logDebug {
                            print("TekoTracker => Send failed", error as NSError)
                        }
                        #endif
                    })
                    .map { _ in eventCount }
                    .catchError ({
                        [weak self] error -> Observable<Int> in
                        guard let self = self, self.shouldSendEventCountIfOccur(error: error) else { throw error }
                        return self.request.sendCount(.init(appID: self.context.appID, count: eventCount))
                            .map { _ in throw error }
                    })
            })
            .flatMap({
                [weak self] count -> Observable<Int> in
                guard let self = self else { return .empty() }
                if count == 0 { return .just(0) }
                return self.request.sendCount(EventCountParams(appID: self.context.appID, count: count))
            })

        _ = Observable
            .zip(
                singleEventUploading
                    .catchErrorJustReturn(0),
                multiEventUploading
                    .catchErrorJustReturn(0)
            ) { _, _ in }
            .subscribe(onNext: {
                [weak self] in
                self?.isSendingBlock = false
            })
    }

    func trySendingEventBlockIfReadyEventCountExceedsThreshold() {
        if readyEventCountInTimingWindow <= Constant.eventUploadBatchSize { return }
        trySendingEventBlock(statuses: [.ready])
        readyEventCountInTimingWindow = 0
        scheduleSendEventRequestBlockIfNeeded()
    }
}

// MARK: - Sync time
private extension TrackerController {
    func syncServerTime() {
        _ = request
            .getServerTime()
            .do(onNext: {
                [weak self] serverTime in
                guard let self = self else { return }
                let distance = serverTime - Date().timeIntervalSince1970
                self.variableStore.distanceToServerTime = distance
                self.currentSession.createdAt += distance
                self.currentSession.lastActiveAt += distance
                self.store?.updateCreatedTime(distanceToServerTime: distance)
            })
            .subscribe(onNext: {
                _ in
                #if !RELEASE || !PRODUCTION
                if self.config.logDebug {
                    print("TekoTracker => Sync server time successfully!")
                }
                #endif
            }, onError: {
                [weak self] error in
                guard let self = self else { return }
                #if !RELEASE || !PRODUCTION
                if self.config.logDebug {
                    print("TekoTracker => Sync time failed", error as NSError)
                }
                #endif
            })
    }
}

#if !RELEASE || !PRODUCTION
struct MockTrackerController: TrackerControllerProtocol {
    func use(userID: String, phoneNumber: String?) {
        print("TekoTracker => Mock Controller", #function)
    }

    func send(_ params: [EventParameter], isImmediate: Bool) {
        print("TekoTracker => Mock Controller", #function)
    }

    func send(_ params: EventParameter, isImmediate: Bool) {
        print("TekoTracker => Mock Controller", #function)
    }

    func logDidEndLoadingTime() {
        print("TekoTracker => Mock Controller", #function)
    }

    func start() {
        print("TekoTracker => Mock Controller", #function)
    }

    func pause() {
        print("TekoTracker => Mock Controller", #function)
    }

    func stop() {
        print("TekoTracker => Mock Controller", #function)
    }
}
#endif
