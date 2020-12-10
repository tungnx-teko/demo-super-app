//
//  TrackingProtocol+Ecommerce+Extension.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/11/20.
//

import Foundation

extension TrackingProtocol {

    public func sendCartEvent(name: EventName, data: CartEventData, isImmediate: Bool = false) {
        send(eventType: .cart, eventName: name, data: data, isImmediate: isImmediate)
    }

    public func sendCartEvent(name: StringIdentifier, data: CartEventData, isImmediate: Bool = false) {
        sendAny(eventType: EventType.cart, eventName: name, data: data, isImmediate: isImmediate)
    }

    public func sendCheckoutEvent(data: CheckoutEventData, isImmediate: Bool = false) {
        send(eventType: .checkout, eventName: .checkout, data: data, isImmediate: isImmediate)
    }

    public func sendPaymentEvent(data: PaymentEventData, isImmediate: Bool = false) {
        send(eventType: .payment, eventName: .payment, data: data, isImmediate: isImmediate)
    }

    public func sendSearchEvent(data: SearchEventData, isImmediate: Bool = false) {
        send(eventType: .search, eventName: .search, data: data, isImmediate: isImmediate)
    }
}
