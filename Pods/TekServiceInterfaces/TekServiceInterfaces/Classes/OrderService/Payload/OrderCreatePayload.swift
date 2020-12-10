//
//  OrderCreatePayload.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 9/14/20.
//

import Foundation

public struct OrderCreatePayload: Encodable {
    public var customer: OrderCustomerParam?
    public var items: [OrderLineItemParam] = []
    public var notes: [Int : String] = [:]
    public var discountInfo: [OrderDiscountParam] = []
    public var billingInfo: OrderBillingParam?
    public var shippingInfo: OrderShippingParam?
    public var grandTotal: Double?
    public var promotions: [OrderPromotionParam] = []
    public var delivery: Bool?
    
    public init() {}
    
    public init(customer: OrderCustomerParam,
                items: [OrderLineItemParam],
                notes: [Int : String],
                discountInfo: [OrderDiscountParam] = [],
                billingInfo: OrderBillingParam? = nil,
                shippingInfo: OrderShippingParam,
                grandTotal: Double,
                promotions: [OrderPromotionParam],
                delivery: Bool?) {
        self.customer = customer
        self.items = items
        self.notes = notes
        self.discountInfo = discountInfo
        self.billingInfo = billingInfo
        self.shippingInfo = shippingInfo
        self.grandTotal = grandTotal
        self.promotions = promotions
        self.delivery = delivery
    }
}

public struct OrderCustomerParam: Encodable {
    public var id: Int
    public var asiaCrmId: String
    public var name: String
    public var phone: String
    public var email: String
    public var fullAddress: String
    
    public init(id: Int,
                asiaCrmId: String,
                name: String,
                phone: String,
                email: String,
                fullAddress: String) {
        self.id = id
        self.asiaCrmId = asiaCrmId
        self.name = name
        self.phone = phone
        self.email = email
        self.fullAddress = fullAddress
    }
}

public struct OrderLineItemParam: Encodable {
    
    public var lineItemId, name, displayName, sku, parentSku: String?
    public var quantity: Int?
    public var warranty: Int?
    public var bizType, price, unitPrice: String?
    public var vatRate: Double?
    public var unitPriceBeforeTax, rowTotal: String?
    public var sellerId: Int?
    public var unitDiscount: Double?
    public var taxOutCode: String?
    
    public init(lineItemId: String?,
                name: String?,
                displayName: String?,
                sku: String?,
                parentSku: String?,
                quantity: Int?,
                warranty: Int?,
                bizType: String?,
                price: String?,
                unitPrice: String?,
                vatRate: Double?,
                unitPriceBeforeTax: String?,
                rowTotal: String?,
                sellerId: Int?,
                unitDiscount: Double?,
                taxOutCode: String?) {
        
        self.lineItemId = lineItemId
        self.name = name
        self.displayName = displayName
        self.sku = sku
        self.parentSku = parentSku
        self.quantity = quantity
        self.warranty = warranty
        self.bizType = bizType
        self.price = price
        self.unitPrice = unitPrice
        self.vatRate = vatRate
        self.unitPriceBeforeTax = unitPriceBeforeTax
        self.rowTotal = rowTotal
        self.sellerId = sellerId
        self.unitDiscount = unitDiscount
        self.taxOutCode = taxOutCode
    }
    
}

public struct OrderDiscountParam: Encodable {
    public var amount: String
    public var sellerId: Int
    
    public init(amount: String, sellerId: Int) {
        self.amount = amount
        self.sellerId = sellerId
    }
}

public struct OrderBillingParam: Encodable {
    public var name, email, address, taxCode, type: String
    public var phone: String?
    public var printAfter: Int?
    public var printPretaxPrice: Bool?
    
    public init(name: String,
                email: String,
                address: String,
                taxCode: String,
                type: String,
                phone: String?,
                printAfter: Int?,
                printPretaxPrice: Bool?) {
        self.name = name
        self.email = email
        self.address = address
        self.taxCode = taxCode
        self.type = type
        self.phone = phone
        self.printAfter = printAfter
        self.printPretaxPrice = printPretaxPrice
    }
    
}

public struct OrderShippingParam: Encodable {
    public var name, phone: String
    public var email: String?
    public var expectedDate: String?
    public var provinceId, address, fullAddress, wardId, districtId: String
    public var country: String?
    public var type: Int?
    public var note: String?
    public var lat, lon: Double?
    
    public init(name: String,
                phone: String,
                email: String?,
                expectedDate: String?,
                provinceId: String,
                address: String,
                fullAddress: String,
                wardId: String,
                districtId: String,
                country: String?,
                type: Int?,
                note: String?,
                lat: Double?,
                lon: Double?) {
        self.name = name
        self.phone = phone
        self.email = email
        self.expectedDate = expectedDate
        self.provinceId = provinceId
        self.address = address
        self.fullAddress = fullAddress
        self.wardId = wardId
        self.districtId = districtId
        self.country = country
        self.type = type
        self.note = note
        self.lat = lat
        self.lon = lon
    }
    
    
}

public struct OrderPromotionParam: Encodable {
    public var id: String
    public var promotionId: String
    public var type: String
    public var applyType: String
    public var quantity: Int
    public var sellerId: Int
    public var gifts: [OrderGiftParam] = []
    public var applyOn: [OrderApplyOnParam] = []
    public var discount: Double
    public var coupon: String?
    public var voucher: OrderVoucherParam?
    
    public init(id: String,
                promotionId: String,
                type: String,
                applyType: String,
                quantity: Int,
                sellerId: Int,
                gifts: [OrderGiftParam],
                applyOn: [OrderApplyOnParam],
                discount: Double,
                coupon: String?,
                voucher: OrderVoucherParam?) {
        self.id = id
        self.promotionId = promotionId
        self.type = type
        self.applyType = applyType
        self.quantity = quantity
        self.sellerId = sellerId
        self.gifts = gifts
        self.applyOn = applyOn
        self.discount = discount
        self.coupon = coupon
        self.voucher = voucher
    }
}

public struct OrderGiftParam: Encodable {
    public var lineItemId: String
    public var sku: String
    public var name: String
    public var quantity: Int
    
    public init(lineItemId: String, sku: String, name: String, quantity: Int) {
        self.lineItemId = lineItemId
        self.sku = sku
        self.name = name
        self.quantity = quantity
    }
}

public struct OrderApplyOnParam: Encodable {
    public var lineItemId: String
    public var quantity: Int
    
    public init(lineItemId: String, quantity: Int) {
        self.lineItemId = lineItemId
        self.quantity = quantity
    }
}

public struct OrderVoucherParam: Encodable {
    public var quantity: Int
    
    public init(quantity: Int) {
        self.quantity = quantity
    }

}
