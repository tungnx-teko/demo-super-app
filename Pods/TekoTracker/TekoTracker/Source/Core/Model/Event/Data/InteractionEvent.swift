//
//  InteractionEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 1/14/20.
//

import Foundation
import CoreGraphics

public enum UserInteraction: String {
    case click
}

final public class InteractionEventData: NSObject, EventDataProtocol, Encodable {
    public var interaction: UserInteraction {
        set { rawInteraction = newValue.rawValue }
        get { UserInteraction(rawValue: rawInteraction)! }
    }
    private var rawInteraction: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(interaction)
    public var objcInteraction: String {
        set {
            if UserInteraction(rawValue: newValue) == nil {
                preconditionFailure("Unsupported interaction type")
            }
            self.rawInteraction = newValue
        }
        get { rawInteraction }
    }
    @objc public var regionName: String
    @objc public var contentName: String
    @objc public var target: String
    @objc public var payload: Any?

    public var relativePosition: CGPoint?

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(relativePosition)
    public var objcRelativePosition: NSValue? {
        set { relativePosition = newValue?.cgPointValue }
        get { relativePosition as NSValue? }
    }

    public var absolutePosition: CGPoint?

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(absolutePosition)
    public var objcAbsolutePosition: NSValue? {
        set { absolutePosition = newValue?.cgPointValue }
        get { absolutePosition as NSValue? }
    }

    enum CodingKeys: String, CodingKey {
        case interaction, regionName, contentName, target, payload
        case relativePositionX, relativePositionY, absolutePositionX, absolutePositionY
    }

    public init(interaction: UserInteraction = .click, regionName: String, contentName: String, target: String, payload: Any? = nil, relativePosition: CGPoint? = nil, absolutePosition: CGPoint? = nil) {
        self.rawInteraction = interaction.rawValue
        self.regionName = regionName
        self.contentName = contentName
        self.target = target
        self.payload = payload
        self.relativePosition = relativePosition
        self.absolutePosition = absolutePosition
        super.init()
    }

    @objc public init(regionName: String, contentName: String, target: String, payload: Any?, relativePosition: NSValue?, absolutePosition: NSValue?) {
        self.rawInteraction = UserInteraction.click.rawValue
        self.regionName = regionName
        self.contentName = contentName
        self.target = target
        self.payload = payload
        self.relativePosition = relativePosition?.cgPointValue
        self.absolutePosition = absolutePosition?.cgPointValue
        super.init()
    }

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc public init(interaction: String, regionName: String, contentName: String, target: String, payload: Any?, relativePosition: NSValue?, absolutePosition: NSValue?) {
        if UserInteraction(rawValue: interaction) == nil {
            assertionFailure("Unsupported interaction type")
        }
        self.rawInteraction = interaction
        self.regionName = regionName
        self.contentName = contentName
        self.target = target
        self.payload = payload
        self.relativePosition = relativePosition?.cgPointValue
        self.absolutePosition = absolutePosition?.cgPointValue
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rawInteraction, forKey: .interaction)
        if regionName.isEmpty {
            try container.encode("undefined", forKey: .regionName)
        } else {
            try container.encode(regionName, forKey: .regionName)
        }
        if contentName.isEmpty {
            try container.encode("undefined", forKey: .contentName)
        } else {
            try container.encode(contentName, forKey: .contentName)
        }
        if target.isEmpty {
            try container.encode("undefined", forKey: .target)
        } else {
            try container.encode(target, forKey: .target)
        }
        if let payload = payload {
            let data = try JSONEncoder().encode(AnyEncodable(payload))
            try container.encode(String(data: data, encoding: .utf8) ?? "undefined", forKey: .payload)
        } else {
            try container.encode("undefined", forKey: .payload)
        }
        try container.encodeIfPresent(relativePosition?.x, forKey: .relativePositionX)
        try container.encodeIfPresent(relativePosition?.y, forKey: .relativePositionY)
        try container.encodeIfPresent(absolutePosition?.x, forKey: .absolutePositionX)
        try container.encodeIfPresent(absolutePosition?.y, forKey: .absolutePositionY)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
