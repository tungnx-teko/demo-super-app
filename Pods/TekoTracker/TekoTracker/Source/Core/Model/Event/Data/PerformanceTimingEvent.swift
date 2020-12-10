//
//  PerformanceTimingEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/14/20.
//

import Foundation

final public class PerformanceTimingEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var channel: String?
    @objc public var terminal: String?
    @objc public var category: String
    @objc public var action: String
    @objc public var actionParam: Any?
    @objc public var actionStartAt: TimeInterval
    @objc public var actionEndAt: TimeInterval
    @objc public var extra: FlattenExtraAttribute?

    enum CodingKeys: String, CodingKey {
        case channel, terminal, category, action, actionParam, actionStartAt, actionEndAt
    }

    @objc public init(channel: String? = nil, terminal: String? = nil, category: String, action: String, actionParam: Any? = nil, actionStartAt: TimeInterval, actionEndAt: TimeInterval, extra: FlattenExtraAttribute? = nil) {
        self.channel = channel
        self.terminal = terminal
        self.category = category
        self.action = action
        self.actionParam = actionParam
        self.actionStartAt = actionStartAt
        self.actionEndAt = actionEndAt
        self.extra = extra
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encodeIfPresent(terminal, forKey: .terminal)
        try container.encode(category, forKey: .category)
        try container.encode(action, forKey: .action)
        try container.encode(String(actionStartAt * 1000), forKey: .actionStartAt)
        try container.encode(String(actionEndAt * 1000), forKey: .actionEndAt)
        if let actionParam = actionParam {
            let data = try JSONEncoder().encode(AnyEncodable(actionParam))
            try container.encode(String(data: data, encoding: .utf8) ?? "undefined", forKey: .actionParam)
        }
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
