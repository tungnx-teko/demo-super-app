//
//  EcommerceEventType.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 1/15/20.
//

extension EventName {
    /// Cart
    static public let addToCart = EventName(value: "addToCart")
    /// Cart
    static public let removeFromCart = EventName(value: "removeFromCart")
    /// Cart
    static public let selectProduct = EventName(value: "selectProduct")
    /// Cart
    static public let unselectProduct = EventName(value: "unselectProduct")
    /// Cart
    static public let revertProductToCart = EventName(value: "revertProductToCart")
    /// Cart
    static public let increaseQuantityProduct = EventName(value: "increaseQuantityProduct")
    /// Cart
    static public let decreaseQuantityProduct = EventName(value: "decreaseQuantityProduct")
    /// Ecommerce
    static public let checkout = EventName(value: "checkout")
    /// Ecommerce
    static public let payment = EventName(value: "payment")
    /// Search
    static public let search = EventName(value: "search")
}

extension EventType {
    static public let cart = EventType(value: "CartEvent", schemaIdentifier: "mobile.cartEvent")
    static public let checkout = EventType(value: "CheckoutEvent", schemaIdentifier: "mobile.checkoutEvent")
    static public let payment = EventType(value: "PaymentEvent", schemaIdentifier: "mobile.paymentEvent")
    static public let search = EventType(value: "SiteSearchEvent", schemaIdentifier: "mobile.siteSearchEvent")
}
