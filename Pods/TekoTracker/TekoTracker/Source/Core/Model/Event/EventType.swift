//
//  CoreEventType.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 2/21/20.
//

public struct EventName: StringIdentifier, Equatable {
    public let value: String

    public init(value: String) {
        self.value = value
    }
}

final public class EventType: EventTypeProtocol {
    public let value: String
    public let schemaIdentifier: String

    init(value: String, schemaIdentifier: String) {
        self.value = value
        self.schemaIdentifier = schemaIdentifier
    }
}
