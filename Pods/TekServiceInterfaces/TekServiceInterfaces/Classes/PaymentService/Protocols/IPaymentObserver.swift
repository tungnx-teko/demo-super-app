//
//  IPaymentObserver.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public protocol IPaymentObserver {
    func observe(transactionCode: String, completion: @escaping (Result<IPaymentTransactionResult, PaymentError>) -> ())
}

