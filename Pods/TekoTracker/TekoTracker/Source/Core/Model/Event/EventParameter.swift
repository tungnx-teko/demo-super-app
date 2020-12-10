//
//  EventParameter.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 6/19/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public struct EventParameter {
    let eventType: String
    let schemaName: String
    let eventName: String
    let data: EventDataProtocol

    public init(eventType: EventType, eventName: EventName, data: EventDataProtocol) {
        self.eventType = eventType.value
        self.schemaName = eventType.schemaIdentifier
        self.eventName = eventName.value
        self.data = data
    }

    public init(eventType: EventTypeProtocol, eventName: StringIdentifier, data: EventDataProtocol) {
        self.eventType = eventType.value
        self.schemaName = eventType.schemaIdentifier
        self.eventName = eventName.value
        self.data = data
    }
}
