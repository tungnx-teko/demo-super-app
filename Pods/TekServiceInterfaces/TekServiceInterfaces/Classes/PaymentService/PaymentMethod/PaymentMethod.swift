//
//  PaymentMethod.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public protocol PaymentMethod {
    associatedtype Request: PaymentRequestProtocol
    associatedtype Transaction: TransactionProtocol
    
    var methodCode: String { get }
    var partnerCode: String { get }
    var bankCode: String { get }
}

