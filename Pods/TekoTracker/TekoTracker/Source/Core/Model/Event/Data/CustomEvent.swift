//
//  CustomEvent.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

final public class CustomEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var utmSource: String?
    @objc public var utmTerm: String?
    @objc public var utmCampaign: String?
    @objc public var utmMedium: String?
    @objc public var utmContent: String?
    @objc public var channel: String?
    @objc public var terminal: String?
    @objc public var property: String?
    @objc public var category: String?
    @objc public var action: String?
    @objc public var label: String?

    public var value: Int?
    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(value)
    public var objcValue: NSNumber? {
        set { value = newValue?.intValue }
        get { value as NSNumber? }
    }

    @objc public var extra: FlattenExtraAttribute?

    enum CodingKeys: String, CodingKey {
        case utmSource, utmTerm, utmCampaign, utmMedium, utmContent, channel, terminal, property, category, action, label, value
    }

    public init(utmSource: String? = nil, utmTerm: String? = nil, utmCampaign: String? = nil, utmMedium: String? = nil, utmContent: String? = nil, channel: String? = nil, terminal: String? = nil, property: String? = nil, category: String? = nil, action: String? = nil, label: String? = nil, value: Int? = nil, extra: FlattenExtraAttribute? = nil) {
        self.utmSource = utmSource
        self.utmTerm = utmTerm
        self.utmCampaign = utmCampaign
        self.utmMedium = utmMedium
        self.utmContent = utmContent
        self.channel = channel
        self.terminal = terminal
        self.property = property
        self.category = category
        self.action = action
        self.label = label
        self.value = value
        self.extra = extra
        super.init()
    }

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc public init(utmSource: String?, utmTerm: String?, utmCampaign: String?, utmMedium: String?, utmContent: String?, channel: String?, terminal: String?, property: String?, category: String?, action: String?, label: String?, value: NSNumber?, extra: FlattenExtraAttribute?) {
        self.utmSource = utmSource
        self.utmTerm = utmTerm
        self.utmCampaign = utmCampaign
        self.utmMedium = utmMedium
        self.utmContent = utmContent
        self.channel = channel
        self.terminal = terminal
        self.property = property
        self.category = category
        self.action = action
        self.label = label
        self.value = value?.intValue
        self.extra = extra
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(utmSource, forKey: .utmSource)
        try container.encodeIfPresent(utmTerm, forKey: .utmTerm)
        try container.encodeIfPresent(utmCampaign, forKey: .utmCampaign)
        try container.encodeIfPresent(utmMedium, forKey: .utmMedium)
        try container.encodeIfPresent(utmContent, forKey: .utmContent)
        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encodeIfPresent(terminal, forKey: .terminal)
        try container.encodeIfPresent(property, forKey: .property)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(action, forKey: .action)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(value, forKey: .value)
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
