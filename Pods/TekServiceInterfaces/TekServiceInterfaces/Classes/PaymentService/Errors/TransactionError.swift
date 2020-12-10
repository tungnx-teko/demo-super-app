//
//  PaymentError.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public enum TransactionError: Int {
    case common
    case processing
    case paymentProcessed
    case balanceNotEnough
    case paymentCancelled
    case paymentMethodNotSupported
    case outOfStock
    
    public init(code: Int) {
        switch code {
        case 999, 887...895, 882...885, 880, 878, 900...901, 780...782, 699, 501, 499:
            self = .common
        case 886:
            self = .processing
        case 881:
            self = .paymentProcessed
        case 879:
            self = .balanceNotEnough
        case 877:
            self = .paymentCancelled
        case 778...779:
            self = .paymentMethodNotSupported
        case 783:
            self = .outOfStock
        default:
            self = .common
        }
    }
    
}
