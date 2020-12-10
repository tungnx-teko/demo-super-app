//
//  IOrderPayment.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/6/20.
//

import Foundation

public protocol IOrderPayment {
    var transactionId: String? { get }
    var paymentMethod: String? { get }
    var amount: Double? { get }
    var updatedAt: String? { get }
    var partnerCode: String? { get }
    var asiaPartnerId: String? { get }
    var terminalCode: String? { get }
    var paymentType: String? { get }
    var merchantCode: String? { get }
    var partnerTransactionCode: String? { get }
}
