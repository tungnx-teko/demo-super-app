//
//  Tracker.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import UIKit

@objc final public class Tracker: NSObject {
    private static var _shared: Tracker?
    @objc public static var shared: Tracker {
        if _shared == nil {
            _shared = Tracker(config: nil)
        }
        return _shared!
    }

    let controller: TrackerControllerProtocol

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc static public func configure(config: TrackerConfigurable?) {
        guard _shared == nil else { return }
        if let config = config {
            _shared = Tracker(config: config)
            return
        }
        configure(configFileURL: nil)
    }

    @objc static public func configure(configFileURL: URL? = nil) {
        guard let url = configFileURL ?? Bundle.main.url(forResource: Constant.configFileName, withExtension: nil) else { return }
        do {
            let configData = try Data(contentsOf: url)
            let config = try PropertyListDecoder().decode(TrackerConfig.self, from: configData)
            _shared = Tracker(config: config)
        } catch {
            #if !RELEASE || !PRODUCTION
            print("TekoTracker => Failed to read config", error as NSError)
            #endif
        }
    }

    convenience init(config: TrackerConfigurable?) {
        if let config = config {
            self.init(controller: TrackerController(config: config))
        } else {
            fatalError("Tracker must be configured")
        }
    }

    init(controller: TrackerControllerProtocol) {
        self.controller = controller
        super.init()
        self.initialize()
    }
}

extension Tracker: TrackingProtocol {
    public func use(userID: String, phoneNumber: String? = nil) {
        controller.use(userID: userID, phoneNumber: phoneNumber)
    }

    public func send(eventType: EventType, eventName: EventName, data: EventDataProtocol, isImmediate: Bool) {
        controller.send(EventParameter(eventType: eventType, eventName: eventName, data: data), isImmediate: isImmediate)
    }

    public func sendAny(eventType: EventTypeProtocol, eventName: StringIdentifier, data: EventDataProtocol, isImmediate: Bool) {
        controller.send(EventParameter(eventType: eventType, eventName: eventName, data: data), isImmediate: isImmediate)
    }

    public func sendGroup(_ events: [EventParameter], isImmediate: Bool) {
        controller.send(events, isImmediate: false)
    }

    public func logDidEndLoadingTime() {
        controller.logDidEndLoadingTime()
    }
}

#if !RELEASE || !PRODUCTION
extension Tracker {
    @objc static public func configureMock() {
        _shared = Tracker(controller: MockTrackerController())
    }
}
#endif

@available(*, message: "Unavailable in Swift", unavailable)
extension Tracker: ObjcTrackingProtocol {
    public func use(forUserID userID: String, phoneNumber: String?) {
        controller.use(userID: userID, phoneNumber: phoneNumber)
    }

    public func send(withEventType eventType: EventTypeProtocol, eventName: String, data: EventDataProtocol, isImmediate: Bool) {
        controller.send(EventParameter(eventType: eventType, eventName: eventName, data: data), isImmediate: isImmediate)
    }
}
