//
//  PaymentRequestProtocol.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public protocol PaymentRequestProtocol {
    var orderId: String { get }
    var orderCode: String { get }
    var orderDescription: String { get }
    var amount: Double { get }
    var cancelUrl: String { get }
    var returnUrl: String { get }
}
