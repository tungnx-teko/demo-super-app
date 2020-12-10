//
//  FlattenExtraAttribute.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 2/27/20.
//

import Foundation

final public class FlattenExtraAttribute: NSObject, Encodable {
    @objc public var first: String?
    @objc public var second: String?
    @objc public var third: String?
    @objc public var fourth: String?
    @objc public var fifth: String?

    enum CodingKeys: String, CodingKey {
        case first = "attr1"
        case second = "attr2"
        case third = "attr3"
        case fourth = "attr4"
        case fifth = "attr5"
    }

    @objc public init(first: String? = nil, second: String? = nil, third: String? = nil, fourth: String? = nil, fifth: String? = nil) {
        self.first = first
        self.second = second
        self.third = third
        self.fourth = fourth
        self.fifth = fifth
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(first, forKey: .first)
        try container.encodeIfPresent(second, forKey: .second)
        try container.encodeIfPresent(third, forKey: .third)
        try container.encodeIfPresent(fourth, forKey: .fourth)
        try container.encodeIfPresent(fifth, forKey: .fifth)
    }
}

extension FlattenExtraAttribute {
    func toScreenExtra() -> ScreenInfo.Extra {
        .init(first: first, second: second, third: third, fourth: fourth, fifth: fifth)
    }
}
