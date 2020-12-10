//
//  Event.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import CoreData

struct Event: Encodable {
    let id: String
    let createdAt: TimeInterval
    let schemaName: String
    let eventName: String
    let eventType: String
    let viewID: String
    let data: Data

    let _encode: ((Encoder) throws -> Void)?

    /// Quick init for testing
    init(eventType: EventTypeProtocol, eventName: StringIdentifier, viewID: String, data: EventDataProtocol, encode: ((Encoder) throws -> Void)? = nil) throws {
        if viewID.isEmpty {
            throw Constant.Error.invalidViewIDEventInitialization
        }
        self.init(id: UUID().uuidString.lowercased(),
                  createdAt: Date().timeIntervalSince1970,
                  eventType: eventType.value,
                  schemaName: eventType.schemaIdentifier,
                  eventName: eventName.value,
                  viewID: viewID,
                  data: try data.asData(),
                  encode: encode)
    }

    init(createdAt: TimeInterval, eventType: EventTypeProtocol, eventName: StringIdentifier, viewID: String, data: EventDataProtocol, encode: ((Encoder) throws -> Void)? = nil) throws {
        if viewID.isEmpty {
            throw Constant.Error.invalidViewIDEventInitialization
        }
        self.init(id: UUID().uuidString.lowercased(),
                  createdAt: createdAt,
                  eventType: eventType.value,
                  schemaName: eventType.schemaIdentifier,
                  eventName: eventName.value,
                  viewID: viewID,
                  data: try data.asData(),
                  encode: encode)
    }

    init(distanceToServerTime: TimeInterval, eventType: EventTypeProtocol, eventName: StringIdentifier, viewID: String, data: EventDataProtocol, encode: ((Encoder) throws -> Void)? = nil) throws {
        if viewID.isEmpty {
            throw Constant.Error.invalidViewIDEventInitialization
        }
        self.init(id: UUID().uuidString.lowercased(),
                  createdAt: Date().timeIntervalSince1970 + distanceToServerTime,
                  eventType: eventType.value,
                  schemaName: eventType.schemaIdentifier,
                  eventName: eventName.value,
                  viewID: viewID,
                  data: try data.asData(),
                  encode: encode)
    }

    init(distanceToServerTime: TimeInterval, eventType: String, schemaName: String, eventName: String, viewID: String, data: EventDataProtocol, encode: ((Encoder) throws -> Void)? = nil) throws {
        if viewID.isEmpty {
            throw Constant.Error.invalidViewIDEventInitialization
        }
        self.init(id: UUID().uuidString.lowercased(),
                  createdAt: Date().timeIntervalSince1970 + distanceToServerTime,
                  eventType: eventType,
                  schemaName: schemaName,
                  eventName: eventName,
                  viewID: viewID,
                  data: try data.asData(),
                  encode: encode)
    }

    init(id: String, createdAt: TimeInterval, eventType: String, schemaName: String, eventName: String, viewID: String, data: Data, encode: ((Encoder) throws -> Void)? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.schemaName = schemaName
        self.eventName = eventName
        self.eventType = eventType
        self.viewID = viewID
        self.data = data
        self._encode = encode
    }

    enum CodingKeys: String, CodingKey {
        case id = "eventId"
        case viewID = "viewId"
        case eventName, eventType, createdAt
    }

    public func encode(to encoder: Encoder) throws {
        if let _encode = _encode {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(eventName, forKey: .eventName)
            try container.encode(eventType, forKey: .eventType)
            try container.encode(Int64(createdAt * 1000), forKey: .createdAt)
            try container.encode(viewID, forKey: .viewID)
            return try _encode(encoder)
        }
        var dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        dict[CodingKeys.id.stringValue] = id
        dict[CodingKeys.eventName.stringValue] = eventName
        dict[CodingKeys.eventType.stringValue] = eventType
        dict[CodingKeys.createdAt.stringValue] = Int64(createdAt * 1000)
        if dict[CodingKeys.viewID.stringValue] == nil {
            if viewID.isEmpty {
                throw Constant.Error.invalidViewIDEventEncoding
            }
            dict[CodingKeys.viewID.stringValue] = viewID
        }
        let anyEncodable = AnyEncodable(dict)
        try anyEncodable.encode(to: encoder)
    }

    func toModel(context: NSManagedObjectContext) -> EventModel {
        .init(event: self, context: context)
    }
}
