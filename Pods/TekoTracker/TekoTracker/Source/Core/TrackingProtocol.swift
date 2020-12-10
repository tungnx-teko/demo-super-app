//
//  TrackingProtocol.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/11/20.
//

import Foundation

public protocol TrackingProtocol {
    func use(userID: String, phoneNumber: String?)
    func send(eventType: EventType, eventName: EventName, data: EventDataProtocol, isImmediate: Bool)
    func sendAny(eventType: EventTypeProtocol, eventName: StringIdentifier, data: EventDataProtocol, isImmediate: Bool)
    func sendGroup(_ events: [EventParameter], isImmediate: Bool)
    func logDidEndLoadingTime()
}

extension TrackingProtocol {
    func use(userID: String) {
        use(userID: userID, phoneNumber: nil)
    }

    public func send(eventType: EventType, eventName: EventName, data: EventDataProtocol) {
        send(eventType: eventType, eventName: eventName, data: data, isImmediate: false)
    }

    public func sendAny(eventType: EventTypeProtocol, eventName: StringIdentifier, data: EventDataProtocol) {
        sendAny(eventType: eventType, eventName: eventName, data: data, isImmediate: false)
    }

    public func sendGroup(_ events: [EventParameter]) {
        sendGroup(events, isImmediate: false)
    }

    public func sendAlertEvent(data: AlertEventData, isImmediate: Bool = false) {
        send(eventType: .alert, eventName: .userAlert, data: data, isImmediate: isImmediate)
    }

    public func sendCustomEvent(name: EventName, data: CustomEventData, isImmediate: Bool = false) {
        send(eventType: .custom, eventName: name, data: data, isImmediate: isImmediate)
    }

    public func sendCustomEvent(name: StringIdentifier, data: CustomEventData, isImmediate: Bool = false) {
        sendAny(eventType: EventType.custom, eventName: name, data: data, isImmediate: isImmediate)
    }

    /// Be careful to use this function, it is not restricted at all
    /// This must be called after calling sendExitScreenEvent(data:isImmediate:), if not, it will certainly lead unexpected behaviors
    public func sendEnterScreenEvent(data: ScreenViewEventData, isImmediate: Bool = false) {
        send(eventType: .screenView, eventName: .enterScreenView, data: data, isImmediate: isImmediate)
    }

    /// Be careful to use this function, it is not restricted at all
    /// This must be called before calling sendEnterScreenEvent(data:isImmediate:), if not, it will certainly lead unexpected behaviors
    public func sendExitScreenEvent(data: ScreenViewEventData, isImmediate: Bool = false) {
        send(eventType: .screenView, eventName: .exitScreenView, data: data, isImmediate: isImmediate)
    }

    public func sendErrorEvent(data: ErrorEventData, isImmediate: Bool = false) {
        send(eventType: .error, eventName: .error, data: data, isImmediate: isImmediate)
    }

    public func sendInteractionContentEvent(data: InteractionEventData, isImmediate: Bool = false) {
        send(eventType: .interaction, eventName: .click, data: data, isImmediate: isImmediate)
    }

    public func sendPerformanceTiming(data: PerformanceTimingEventData, isImmediate: Bool = false) {
        send(eventType: .performanceTiming, eventName: .performanceTiming, data: data)
    }

    public func sendVisibleContentEvent(data: [VisibleContentEventData], isImmediate: Bool = false) {
        sendGroup(data.map { EventParameter(eventType: .visibleContent, eventName: .visibleContent, data: $0) }, isImmediate: isImmediate)
    }
}
