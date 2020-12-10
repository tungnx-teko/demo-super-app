//
//  AlertEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/5/20.
//

import Foundation

final public class AlertEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var channel: String?
    @objc public var terminal: String?
    @objc public var alertType: String
    @objc public var alertMessage: String
    @objc public var extra: FlattenExtraAttribute?

    enum CodingKeys: String, CodingKey {
        case channel, terminal, alertType, alertMessage
    }

    @objc public init(channel: String? = nil, terminal: String? = nil, alertType: String, alertMessage: String, extra: FlattenExtraAttribute? = nil) {
        self.channel = channel
        self.terminal = terminal
        self.alertType = alertType
        self.alertMessage = alertMessage
        self.extra = extra
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encodeIfPresent(terminal, forKey: .terminal)
        try container.encode(alertType, forKey: .alertType)
        try container.encode(alertMessage, forKey: .alertMessage)
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
