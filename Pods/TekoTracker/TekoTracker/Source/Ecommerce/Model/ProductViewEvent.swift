//
//  ProductViewEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 1/14/20.
//

import Foundation

final public class ProductViewEventData: ScreenViewEventData {
    @objc public var sku: String
    @objc public var productName: String
    @objc public var channel: String
    @objc public var terminal: String

    enum ProductCodingKeys: String, CodingKey {
        case productName = "skuName"
        case sku = "skuId"
        case channel, terminal
    }

    @objc public init(screenName: String, sku: String, productName: String, channel: String, terminal: String, contentType: String, title: String? = nil, href: String? = nil, extra: FlattenExtraAttribute? = nil, navigationStart: TimeInterval = 0, loadEventEnd: TimeInterval = 0) {
        self.sku = sku
        self.productName = productName
        self.channel = channel
        self.terminal = terminal
        super.init(screenName: screenName, contentType: contentType, title: title, href: href, extra: extra, navigationStart: navigationStart, loadEventEnd: loadEventEnd)
    }

    init(screenName: String, referrerScreenName: String, sku: String, productName: String, channel: String, terminal: String, contentType: String, title: String?, href: String?, extra: FlattenExtraAttribute?, navigationStart: TimeInterval, loadEventEnd: TimeInterval) {
        self.sku = sku
        self.productName = productName
        self.channel = channel
        self.terminal = terminal
        super.init(screenName: screenName, referrerScreenName: referrerScreenName, contentType: contentType, title: title, href: href, extra: extra, navigationStart: navigationStart, loadEventEnd: loadEventEnd)
    }

    override public func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: ProductCodingKeys.self)
        try container.encode(sku, forKey: .sku)
        try container.encode(productName, forKey: .productName)
        try container.encode(channel, forKey: .channel)
        try container.encode(terminal, forKey: .terminal)
    }
}
