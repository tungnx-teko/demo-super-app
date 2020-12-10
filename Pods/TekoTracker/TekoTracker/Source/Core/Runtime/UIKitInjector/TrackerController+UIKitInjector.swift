//
//  TrackerController+UIViewControllerInjector.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 4/27/20.
//

import UIKit
import DeviceKit

extension TrackerController: UIKitInjectorDelegate {

    func uiKitInjector(_ injector: UIKitInjector, willAppear viewController: UIViewController) {
        guard shouldAutoTrack(viewController: viewController) else { return }
        let shouldSendManualEvent = shouldSendManualEnterExitPreviousScreenViewEvent(from: viewController)
        let lastScreenInfo = variableStore.lastScreenInfo
        if shouldSendManualEvent, let currentScreenInfo = lastScreenInfo {
            sendExitScreenViewEvent(currentScreenInfo: currentScreenInfo)
        } else {
            variableStore.popLastScreenInfo()
        }
        sendEnterScreenViewEvent(of: viewController, lastScreenInfo: lastScreenInfo)
        sendAlertEvent(of: viewController)
    }

    func uiKitInjector(_ injector: UIKitInjector, willDisappear viewController: UIViewController) {
        guard shouldAutoTrack(viewController: viewController) else { return }
        sendPendingEnterScreenViewEvent()
        if let lastScreenInfo = variableStore.lastScreenInfo {
            sendExitScreenViewEvent(of: viewController, lastScreenInfo: lastScreenInfo)
        }
        guard shouldSendManualEnterExitPreviousScreenViewEvent(from: viewController),
            let lastScreenInfo = variableStore.lastScreenInfo else { return }
        variableStore.popLastScreenInfo()
        guard let currentScreenInfo = variableStore.lastScreenInfo else { return }

        // Re-generate new viewID for presenting view controller
        currentScreenInfo.viewID = UUID().uuidString.lowercased()

        sendEnterScreenViewEvent(currentScreenInfo: currentScreenInfo, lastScreenInfo: lastScreenInfo)
    }

    func uiKitInjector(_ injector: UIKitInjector, willEndDragging scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let lastVelocity = scrollViewVelocityDict[scrollView.hashValue],
            abs(lastVelocity.x) < Constant.upperRangeScrollingVelocity && abs(lastVelocity.y) < Constant.upperRangeScrollingVelocity {
            self.trackScrollView(scrollView)
        }
        scrollViewVelocityDict[scrollView.hashValue] = velocity
    }

    func uiKitInjector(_ injector: UIKitInjector, didEndDecelerating scrollView: UIScrollView) {
        self.trackScrollView(scrollView)
        scrollViewVelocityDict[scrollView.hashValue] = nil
    }

    func uiKitInjector(_ injector: UIKitInjector, touchesEnded touches: Set<UITouch>, with event: UIEvent?, in view: UIView) {
        DispatchQueue.main.async {
            self.trackTapTouches(touches, with: event, in: view)
        }
    }

    func uiKitInjector(_ injector: UIKitInjector, handle control: UIControl, withControlEvent controlEvent: UIControl.Event) {
        DispatchQueue.main.async {
            self.trackControl(control)
        }
    }

}

// MARK: - CreateScreenViewData
extension TrackerController {

    @inlinable
    func shouldAutoTrack(viewController: UIViewController) -> Bool {
        if config.manuallyLogViewController { return false }
        guard let viewControllerName = viewController.trackingName else { return false }
        return !config.manuallyLogTrackingNames.contains(viewControllerName)
    }

    @objc(createScreenViewDataFromViewController:lastScreenViewName:navigationStart:loadEventEnd:)
    dynamic func createScreenViewData(fromViewController viewController: UIViewController, lastScreenViewName: String, navigationStart: TimeInterval, loadEventEnd: TimeInterval) -> ScreenViewEventData {
        let viewControllerName = viewController.trackingName ?? ""
        return .init(
            screenName: viewControllerName,
            referrerScreenName: lastScreenViewName,
            contentType: viewController.trackingContentType ?? "",
            title: viewController.trackingTitle,
            href: viewController.trackingHref,
            extra: nil,
            navigationStart: navigationStart,
            loadEventEnd: loadEventEnd
        )
    }

    @inlinable
    func shouldSendManualEnterExitPreviousScreenViewEvent(from viewController: UIViewController) -> Bool {
        var parent = viewController
        while let p = parent.parent {
            parent = p
        }
        guard parent.presentingViewController != nil else { return false }
        if #available(iOS 13, *) {
            switch parent.modalPresentationStyle {
            case .automatic, .custom, .formSheet, .overCurrentContext, .overFullScreen, .pageSheet, .popover:
                return true
            default:
                return false
            }
        } else {
            switch parent.modalPresentationStyle {
            case .custom, .overCurrentContext, .overFullScreen:
                return true
            case .formSheet, .pageSheet, .popover:
                return Device.current.isPad
            default:
                return false
            }
        }
    }

    @inlinable
    func sendEnterScreenViewEvent(of viewController: UIViewController, lastScreenInfo: ScreenInfo?) {
        guard let viewControllerName = viewController.trackingName else { return }
        if config.manuallyLogViewController || config.manuallyLogTrackingNames.contains(viewControllerName) { return }
        // Generate new viewID for new view controller
        let viewID = UUID().uuidString.lowercased()
        let navigationStart = Date().timeIntervalSince1970 + variableStore.distanceToServerTime
        variableStore.lastScreenInfo = .init(
            viewID: viewID,
            name: viewControllerName,
            referrer: lastScreenInfo?.name ?? "",
            contentType: viewController.trackingContentType,
            title: viewController.trackingTitle,
            href: viewController.trackingHref,
            extra: nil,
            shouldHoldToTrackOnLoad: viewController.shouldHoldToTrackOnLoad,
            navigationStart: navigationStart,
            loadEventEnd: 0
        )
        if viewController.shouldHoldToTrackOnLoad { return }
        variableStore.lastScreenInfo?.isConfirmed = true
        let eventData = createScreenViewData(
            fromViewController: viewController,
            lastScreenViewName: lastScreenInfo?.name ?? "",
            navigationStart: 0,
            loadEventEnd: 0
        )
        do {
            let event = try Event(
                distanceToServerTime: variableStore.distanceToServerTime,
                eventType: EventType.screenView,
                eventName: EventName.enterScreenView,
                viewID: viewID,
                data: eventData,
                encode: eventData.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func sendExitScreenViewEvent(of viewController: UIViewController, lastScreenInfo: ScreenInfo) {
        guard let viewControllerName = viewController.trackingName else { return }
        if config.manuallyLogViewController || config.manuallyLogTrackingNames.contains(viewControllerName) { return }
        let eventData = createScreenViewData(fromViewController: viewController, lastScreenViewName: viewControllerName, navigationStart: 0, loadEventEnd: 0)
        do {
            let event = try Event(
                distanceToServerTime: variableStore.distanceToServerTime,
                eventType: EventType.screenView,
                eventName: EventName.exitScreenView,
                viewID: lastScreenInfo.viewID,
                data: eventData,
                encode: eventData.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func sendAlertEvent(of viewController: UIViewController) {
        guard let alertTrackable = viewController as? AlertTrackable else { return }
        if let alertViewController = viewController as? UIAlertController, !alertViewController.shouldTrackAsAlert {
            return
        }
        let eventData = AlertEventData(
            alertType: alertTrackable.trackingAlertType ?? "",
            alertMessage: alertTrackable.trackingAlertMessage ?? ""
        )
        do {
            let event = try Event(
                eventType: EventType.alert,
                eventName: EventName.userAlert,
                viewID: variableStore.lastScreenInfo?.viewID ?? "",
                data: eventData,
                encode: eventData.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func sendPendingEnterScreenViewEvent() {
        guard let currentScreenInfo = variableStore.lastScreenInfo, currentScreenInfo.shouldHoldToTrackOnLoad else { return }
        if currentScreenInfo.isConfirmed { return }
        if config.manuallyLogViewController || config.manuallyLogTrackingNames.contains(currentScreenInfo.name) { return }
        let eventData = ScreenViewEventData(
            screenName: currentScreenInfo.name,
            referrerScreenName: currentScreenInfo.referrer,
            contentType: currentScreenInfo.contentType ?? "",
            title: currentScreenInfo.title,
            href: currentScreenInfo.href,
            extra: currentScreenInfo.extra?.toFlattenExtraAttribute(),
            navigationStart: currentScreenInfo.navigationStart,
            loadEventEnd: currentScreenInfo.loadEventEnd
        )
        do {
            let event = try Event(
                createdAt: currentScreenInfo.navigationStart,
                eventType: EventType.screenView,
                eventName: EventName.enterScreenView,
                viewID: currentScreenInfo.viewID,
                data: eventData,
                encode: eventData.encode
            )
            send(event: event)
        }
        catch {}
        currentScreenInfo.isConfirmed = true
    }

    @inlinable
    func sendEnterScreenViewEvent(currentScreenInfo: ScreenInfo, lastScreenInfo: ScreenInfo) {
        if config.manuallyLogViewController || config.manuallyLogTrackingNames.contains(currentScreenInfo.name) { return }
        currentScreenInfo.isConfirmed = true
        let eventData = ScreenViewEventData(
            screenName: currentScreenInfo.name,
            referrerScreenName: lastScreenInfo.name,
            contentType: currentScreenInfo.contentType ?? "",
            title: currentScreenInfo.title,
            href: currentScreenInfo.href,
            extra: currentScreenInfo.extra?.toFlattenExtraAttribute(),
            navigationStart: lastScreenInfo.navigationStart,
            loadEventEnd: lastScreenInfo.loadEventEnd
        )
        do {
            let event = try Event(
                distanceToServerTime: variableStore.distanceToServerTime,
                eventType: EventType.screenView,
                eventName: EventName.enterScreenView,
                viewID: currentScreenInfo.viewID,
                data: eventData,
                encode: eventData.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func sendExitScreenViewEvent(currentScreenInfo: ScreenInfo) {
        if config.manuallyLogViewController || config.manuallyLogTrackingNames.contains(currentScreenInfo.name) { return }
        let eventData = ScreenViewEventData(
            screenName: currentScreenInfo.name,
            referrerScreenName: currentScreenInfo.name,
            contentType: currentScreenInfo.contentType ?? "",
            title: currentScreenInfo.title,
            href: currentScreenInfo.href,
            extra: currentScreenInfo.extra?.toFlattenExtraAttribute(),
            navigationStart: 0,
            loadEventEnd: 0
        )
        do {
            let event = try Event(
                distanceToServerTime: variableStore.distanceToServerTime,
                eventType: EventType.screenView,
                eventName: EventName.exitScreenView,
                viewID: currentScreenInfo.viewID,
                data: eventData,
                encode: eventData.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func trackTapTouches(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) {
        guard let view = touches
            .filter ({ $0.type == .direct || $0.type == .pencil })
            .compactMap ({ $0.view })
            .filter({ $0.isReadyToTrack })
            .first ?? (view.isReadyToTrack ? view : nil) else { return }
        let data = InteractionEventData(
            regionName: view.trackingRegionName ?? "",
            contentName: view.trackingContentName ?? "",
            target: view.trackingTarget ?? "",
            payload: view.trackingPayload,
            relativePosition: view.convert(.zero, to: view.superview),
            absolutePosition: view.convert(.zero, to: view.window)
        )
        do {
            let event = try Event(
                distanceToServerTime: variableStore.distanceToServerTime,
                eventType: EventType.interaction,
                eventName: EventName.click,
                viewID: variableStore.lastScreenInfo?.viewID ?? "",
                data: data,
                encode: data.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func trackControl(_ control: UIControl) {
        guard control.isReadyToTrack else { return }
        let data = InteractionEventData(
            regionName: control.trackingRegionName ?? "",
            contentName: control.trackingContentName ?? "",
            target: control.trackingTarget ?? "",
            payload: control.trackingPayload,
            relativePosition: control.convert(.zero, to: control.superview),
            absolutePosition: control.convert(.zero, to: control.window)
        )
        do {
            let event = try Event(
                distanceToServerTime: variableStore.distanceToServerTime,
                eventType: EventType.interaction,
                eventName: EventName.click,
                viewID: variableStore.lastScreenInfo?.viewID ?? "",
                data: data,
                encode: data.encode
            )
            send(event: event)
        }
        catch {}
    }

    @inlinable
    func createVisibleContentEvent(from view: UIView) -> Event? {
        let data = VisibleContentEventData(
            index: view.trackingIndex,
            regionName: view.trackingRegionName ?? "",
            contentName: view.trackingContentName ?? ""
        )
        do {
            return try Event(
                eventType: EventType.visibleContent,
                eventName: EventName.visibleContent,
                viewID: variableStore.lastScreenInfo?.viewID ?? "",
                data: data,
                encode: data.encode
            )
        } catch {
            #if !RELEASE || !PRODUCTION
            if config.logDebug {
                print("TekoTracker => Failed to initialize a visible content event", error.localizedDescription)
            }
            #endif
            return nil
        }
    }

    @inlinable
    func trackScrollView(_ scrollView: UIScrollView) {
        switch scrollView {
        case let tableView as UITableView:
            let events: [Event] = tableView.visibleCells
                .flatMap { $0.trackableViews }
                .compactMap(createVisibleContentEvent(from:))
            if events.isEmpty { break }
            sendGroup(events: events)
        case let collectionView as UICollectionView:
            let events: [Event] = collectionView.visibleCells
                .flatMap { $0.trackableViews }
                .compactMap(createVisibleContentEvent(from:))
            if events.isEmpty { break }
            sendGroup(events: events)
        default:
            let events: [Event] = scrollView.subviews
                .flatMap { $0.trackableViews }
                .filter ({
                    guard let superview = $0.superview else { return false }
                    if superview === scrollView {
                        return scrollView.bounds.contains($0.frame)
                    }
                    return scrollView.bounds.contains(superview.convert($0.frame, to: scrollView))
                })
                .compactMap(createVisibleContentEvent(from:))
            if events.isEmpty { break }
            sendGroup(events: events)
        }
    }
}
