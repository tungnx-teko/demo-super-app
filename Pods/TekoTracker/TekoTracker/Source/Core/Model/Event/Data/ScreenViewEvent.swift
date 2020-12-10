//
//  ScreenViewEnvent.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

public class ScreenViewEventData: NSObject, EventDataProtocol, Encodable {
    @objc internal(set) public var referrerScreenName: String
    @objc public var screenName: String
    @objc public var contentType: String
    @objc public var title: String?
    @objc public var href: String?
    @objc public var extra: FlattenExtraAttribute?
    @objc public var navigationStart: TimeInterval
    @objc public var loadEventEnd: TimeInterval

    enum CodingKeys: String, CodingKey {
        case referrerScreenName = "referrer"
        case title = "pageTitle"
        case screenName, contentType, href, navigationStart, loadEventEnd
    }

    @objc public init(screenName: String, contentType: String, title: String? = nil, href: String? = nil, extra: FlattenExtraAttribute? = nil, navigationStart: TimeInterval = 0, loadEventEnd: TimeInterval = 0) {
        self.referrerScreenName = ""
        self.screenName = screenName
        self.contentType = contentType
        self.title = title
        self.href = href
        self.extra = extra
        self.navigationStart = navigationStart
        self.loadEventEnd = loadEventEnd
        super.init()
    }

    init(screenName: String, referrerScreenName: String, contentType: String, title: String?, href: String?, extra: FlattenExtraAttribute?, navigationStart: TimeInterval, loadEventEnd: TimeInterval) {
        self.screenName = screenName
        self.referrerScreenName = referrerScreenName
        self.contentType = contentType
        self.title = title
        self.href = href
        self.extra = extra
        self.navigationStart = navigationStart
        self.loadEventEnd = loadEventEnd
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(screenName, forKey: .screenName)
        try container.encode(referrerScreenName, forKey: .referrerScreenName)
        if contentType.isEmpty {
            try container.encode("undefined", forKey: .contentType)
        } else {
            try container.encode(contentType, forKey: .contentType)
        }
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(href, forKey: .href)
        if navigationStart > 0 {
            try container.encode(Int64(navigationStart * 1000), forKey: .navigationStart)
        }
        if loadEventEnd > 0 {
            try container.encode(Int64(loadEventEnd * 1000), forKey: .loadEventEnd)
        }
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension ScreenViewEventData {
    func toScreenInfo(viewID: String, referrer: String) -> ScreenInfo {
        .init(viewID: viewID, name: screenName, referrer: referrer, contentType: contentType, title: title, href: href, extra: extra?.toScreenExtra(), shouldHoldToTrackOnLoad: loadEventEnd > 0, navigationStart: navigationStart, loadEventEnd: loadEventEnd)
    }
}
