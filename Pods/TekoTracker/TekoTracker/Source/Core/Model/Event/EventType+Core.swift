//
//  EventType+Core.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 6/19/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension EventName {
    /// Alert
    static public let userAlert = EventName(value: "userAlert")
    /// Content
    static public let click = EventName(value: "click")
    /// Content
    static public let visibleContent = EventName(value: "visibleContent")
    /// Screen view
    static public let enterScreenView = EventName(value: "enterScreenView")
    /// Screen view
    static public let exitScreenView = EventName(value: "exitScreenView")
    /// Error
    static public let error = EventName(value: "error")
    /// Performance Timing
    static public let performanceTiming = EventName(value: "performanceTiming")
}

extension EventType: Equatable {
    public static func == (lhs: EventType, rhs: EventType) -> Bool {
        lhs.value == rhs.value && lhs.schemaIdentifier == rhs.schemaIdentifier
    }

    static public let alert = EventType(value: "AlertEvent", schemaIdentifier: "mobile.alertEvent")
    static public let custom = EventType(value: "CustomEvent", schemaIdentifier: "mobile.customEvent")
    static public let error = EventType(value: "ErrorEvent", schemaIdentifier: "mobile.errorEvent")
    static public let interaction = EventType(value: "ContentEvent", schemaIdentifier: "mobile.interactionContentEvent")
    static public let performanceTiming = EventType(value: "PerformanceTimingEvent", schemaIdentifier: "mobile.performanceTimingEvent")
    static public let screenView = EventType(value: "ScreenViewEvent", schemaIdentifier: "mobile.screenViewEvent")
    static public let timing = EventType(value: "TimingEvent", schemaIdentifier: "mobile.timingEvent")
    static public let visibleContent = EventType(value: "ContentEvent", schemaIdentifier: "mobile.visibleContentEvent")
}
