//
//  CheckoutEventData.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

final public class CheckoutEventData: NSObject, EventDataProtocol, Encodable {
    @objc(EcommerceProduct)
    public class Product: NSObject, Encodable {
        @objc public var sku: String
        @objc public var name: String
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

        enum CodingKeys: String, CodingKey {
            case sku = "skuId"
            case name = "skuName"
            case price, promotionPrice, quantity
        }

        public init(sku: String, name: String, price: Double, promotionPrice: Double? = nil, quantity: Int) {
            self.sku = sku
            self.name = name
            self.price = price
            self.promotionPrice = promotionPrice
            self.quantity = quantity
            super.init()
        }

        @available(*, message: "Unavailable in Swift", unavailable)
        @objc public init(sku: String, name: String, price: Double, promotionPrice: NSNumber?, quantity: Int) {
            self.sku = sku
            self.name = name
            self.price = price
            self.promotionPrice = promotionPrice?.doubleValue
            self.quantity = quantity
            super.init()
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(sku, forKey: .sku)
            try container.encode(name, forKey: .name)
            try container.encode(price, forKey: .price)
            try container.encode(promotionPrice ?? price, forKey: .promotionPrice)
            try container.encode(quantity, forKey: .quantity)
        }
    }

    @objc public var orderID: String
    @objc public var grandTotal: Double
    @objc public var amountBeforeDiscount: Double
    @objc public var tax: Double
    @objc public var discountAmount: Double
    @objc public var products: [Product]
    @objc public var note: String
    @objc public var shippingFee: Double
    @objc public var shippingPartner: String?
    @objc public var shippingAddressCode: String?
    @objc public var shippingProvince: String?
    @objc public var shippingDistrict: String?
    @objc public var shippingWard: String?
    @objc public var shippingStreet: String?
    @objc public var shippingAddress: String?

    public var paymentMethod: PaymentMethod {
        set { rawPaymentMethod = newValue.rawValue }
        get { PaymentMethod(rawValue: rawPaymentMethod)! }
    }
    private var rawPaymentMethod: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(paymentMethod)
    public var objcPaymentMethod: String {
        set {
            if PaymentMethod(rawValue: newValue) == nil {
                preconditionFailure("Unsupported payment method")
            }
            rawPaymentMethod = newValue
        }
        get { rawPaymentMethod }
    }
    @objc public var paymentBank: String?

    public var status: EcommerceEventStatus {
        set { rawStatus = newValue.rawValue }
        get { EcommerceEventStatus(rawValue: rawStatus)! }
    }
    private var rawStatus: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(status)
    public var objcStatus: String {
        set {
            if EcommerceEventStatus(rawValue: newValue) == nil {
                preconditionFailure("Unsupported status")
            }
            rawStatus = newValue
        }
        get { rawStatus }
    }
    /// Extra info
    @objc public var extra: FlattenExtraAttribute?

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case grandTotal = "amountAfterDiscount"
        case amountBeforeDiscount, discountAmount, tax, products, paymentMethod, paymentBank, note, status
        case shippingFee, shippingPartner, shippingAddressCode, shippingProvince, shippingDistrict, shippingWard, shippingStreet, shippingAddress
    }

    public init(orderID: String,
                grandTotal: Double,
                amountBeforeDiscount: Double,
                tax: Double,
                discountAmount: Double,
                products: [Product] = [],
                paymentMethod: PaymentMethod,
                paymentBank: String? = nil,
                shippingFee: Double = 0,
                shippingPartner: String? = nil,
                shippingAddressCode: String? = nil,
                shippingProvince: String? = nil,
                shippingDistrict: String? = nil,
                shippingWard: String? = nil,
                shippingStreet: String? = nil,
                shippingAddress: String? = nil,
                note: String = "",
                status: EcommerceEventStatus,
                extra: FlattenExtraAttribute? = nil) {
        self.orderID = orderID
        self.grandTotal = grandTotal
        self.amountBeforeDiscount = amountBeforeDiscount
        self.tax = tax
        self.discountAmount = discountAmount
        self.products = products
        self.rawPaymentMethod = paymentMethod.rawValue
        self.paymentBank = paymentBank
        self.shippingFee = shippingFee
        self.shippingPartner = shippingPartner
        self.shippingAddressCode = shippingAddressCode
        self.shippingProvince = shippingProvince
        self.shippingDistrict = shippingDistrict
        self.shippingWard = shippingWard
        self.shippingStreet = shippingStreet
        self.shippingAddress = shippingAddress
        self.note = note
        self.rawStatus = status.rawValue
        self.extra = extra
        super.init()
    }

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc public init(orderID: String,
                      grandTotal: Double,
                      amountBeforeDiscount: Double,
                      tax: Double,
                      discountAmount: Double,
                      products: [Product],
                      paymentMethod: String,
                      paymentBank: String?,
                      shippingFee: Double,
                      shippingPartner: String?,
                      shippingAddressCode: String?,
                      shippingProvince: String?,
                      shippingDistrict: String?,
                      shippingWard: String?,
                      shippingStreet: String?,
                      shippingAddress: String?,
                      note: String,
                      status: String,
                      extra: FlattenExtraAttribute?) {
        if PaymentMethod(rawValue: paymentMethod) == nil {
            preconditionFailure("Unsupported payment method")
        }
        if EcommerceEventStatus(rawValue: status) == nil {
            preconditionFailure("Unsupported status")
        }
        self.orderID = orderID
        self.grandTotal = grandTotal
        self.amountBeforeDiscount = amountBeforeDiscount
        self.tax = tax
        self.discountAmount = discountAmount
        self.products = products
        self.rawPaymentMethod = paymentMethod
        self.paymentBank = paymentBank
        self.shippingFee = shippingFee
        self.shippingPartner = shippingPartner
        self.shippingAddressCode = shippingAddressCode
        self.shippingProvince = shippingProvince
        self.shippingDistrict = shippingDistrict
        self.shippingWard = shippingWard
        self.shippingStreet = shippingStreet
        self.shippingAddress = shippingAddress
        self.note = note
        self.rawStatus = status
        self.extra = extra
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderID, forKey: .orderID)
        try container.encode(grandTotal, forKey: .grandTotal)
        try container.encode(amountBeforeDiscount, forKey: .amountBeforeDiscount)
        try container.encode(tax, forKey: .tax)
        try container.encode(discountAmount, forKey: .discountAmount)
        try container.encode(products, forKey: .products)
        try container.encode(rawPaymentMethod, forKey: .paymentMethod)
        try container.encodeIfPresent(paymentBank, forKey: .paymentBank)
        try container.encode(shippingFee, forKey: .shippingFee)
        try container.encodeIfPresent(shippingPartner, forKey: .shippingPartner)
        try container.encodeIfPresent(shippingAddressCode, forKey: .shippingAddressCode)
        try container.encodeIfPresent(shippingProvince, forKey: .shippingProvince)
        try container.encodeIfPresent(shippingDistrict, forKey: .shippingDistrict)
        try container.encodeIfPresent(shippingWard, forKey: .shippingWard)
        try container.encodeIfPresent(shippingStreet, forKey: .shippingStreet)
        try container.encodeIfPresent(shippingAddress, forKey: .shippingAddress)
        try container.encode(note, forKey: .note)
        try container.encode(rawStatus, forKey: .status)
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
