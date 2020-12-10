//
//  OrderConfirmPayload.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 9/14/20.
//

import Foundation

public struct MarketOrderConfirmPaymentPayload: Encodable {
    let payments: [MarketOrderPaymentParam]
    
    public init(payments: [MarketOrderPaymentParam]) {
        self.payments = payments
    }
}

public struct MarketOrderPaymentParam: Encodable {
    let methodCode: String
    let amount: Double
    
    public init(methodCode: String, amount: Double) {
        self.methodCode = methodCode
        self.amount = amount
    }
}

