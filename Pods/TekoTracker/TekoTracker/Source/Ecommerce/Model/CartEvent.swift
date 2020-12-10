//
//  CartEventData.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

final public class CartEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var cartID: String
    @objc public var sku: String
    @objc public var name: String
    /// Default price
    @objc public var price: Double
    /// Final price
    public var promotionPrice: Double?
    /// Final price
    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(promotionPrice)
    public var objPromotionPrice: NSNumber? {
        set { promotionPrice = newValue?.doubleValue }
        get { promotionPrice as NSNumber? }
    }
    @objc public var quantity: Int
    /// Promotion IDs
    @objc public var promotions: [String]
    @objc public var coupon: String?

    public var status: CartEventStatus {
        set { rawStatus = newValue.rawValue }
        get { CartEventStatus(rawValue: rawStatus)! }
    }
    private var rawStatus: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(status)
    public var objcStatus: String {
        set {
            if CartEventStatus(rawValue: newValue) == nil {
                preconditionFailure("Unsupported status")
            }
            rawStatus = newValue
        }
        get { rawStatus }
    }

    @objc public var extra: FlattenExtraAttribute?

    enum CodingKeys: String, CodingKey {
        case cartID = "cartId"
        case sku = "skuId"
        case name = "skuName"
        case promotions = "promotionId"
        case price, promotionPrice, quantity, coupon, status
    }

    public init(cartID: String, sku: String, name: String, price: Double, promotionPrice: Double? = nil, quantity: Int, promotions: [String] = [], coupon: String? = nil, status: CartEventStatus, extra: FlattenExtraAttribute? = nil) {
        self.cartID = cartID
        self.sku = sku
        self.name = name
        self.price = price
        self.promotionPrice = promotionPrice
        self.quantity = quantity
        self.promotions = promotions
        self.coupon = coupon
        self.rawStatus = status.rawValue
        self.extra = extra
        super.init()
    }

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc public init(cartID: String, sku: String, name: String, price: Double, promotionPrice: NSNumber?, quantity: Int, currency: String, promotions: [String], coupon: String?, status: String, extra: FlattenExtraAttribute?) {
        if CartEventStatus(rawValue: status) == nil {
            preconditionFailure("Unsupported status")
        }
        self.cartID = cartID
        self.sku = sku
        self.name = name
        self.price = price
        self.promotionPrice = promotionPrice?.doubleValue
        self.quantity = quantity
        self.promotions = promotions
        self.coupon = coupon
        self.rawStatus = status
        self.extra = extra
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cartID, forKey: .cartID)
        try container.encode(sku, forKey: .sku)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(promotionPrice ?? price, forKey: .promotionPrice)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(promotions.joined(separator: ","), forKey: .promotions)
        try container.encodeIfPresent(coupon, forKey: .coupon)
        try container.encode(rawStatus, forKey: .status)
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
