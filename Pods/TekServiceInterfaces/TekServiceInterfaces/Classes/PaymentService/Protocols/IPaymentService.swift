//
//  IPaymentService.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public typealias PaymentPayload = [String: Any]

public protocol IPaymentService {
    func pay<T: PaymentMethod>(method: T, request: T.Request, completion: @escaping (Result<T.Transaction, PaymentError>) -> ())
}
