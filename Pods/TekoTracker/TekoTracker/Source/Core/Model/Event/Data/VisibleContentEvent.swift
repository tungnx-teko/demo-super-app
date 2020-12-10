//
//  VisibleContentEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 1/17/20.
//

import Foundation

final public class VisibleContentEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var index: Int
    @objc public var regionName: String
    @objc public var contentName: String

    enum CodingKeys: String, CodingKey {
        case index, regionName, contentName
    }

    @objc public init(index: Int, regionName: String, contentName: String) {
        self.index = index
        self.regionName = regionName
        self.contentName = contentName
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
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
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
