//
//  TimingEvent.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

final public class TimingEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var channel: String?
    @objc public var category: String?
    @objc public var variable: String?
    @objc public var label: String?
    @objc public var duration: TimeInterval
    @objc public var extra: FlattenExtraAttribute?

    enum CodingKeys: String, CodingKey {
        case channel, category, variable, label, duration
    }

    @objc public init(channel: String?, category: String?, variable: String?, label: String?, duration: TimeInterval, extra: FlattenExtraAttribute? = nil) {
        self.channel = channel
        self.category = category
        self.variable = variable
        self.label = label
        self.duration = duration
        self.extra = extra
        super.init()
    }

    @objc public init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(variable, forKey: .variable)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encode(Int64(duration * 1000), forKey: .duration)
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
