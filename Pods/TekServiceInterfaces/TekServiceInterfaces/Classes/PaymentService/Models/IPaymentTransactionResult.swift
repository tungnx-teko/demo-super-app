//
//  IPaymentTransactionResult.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public protocol IPaymentTransactionResult {
    var amount: Double? { get }
    var message: String? { get }
    var ref: String? { get }
    var status: String? { get }
    var transactionId: String? { get }
}
