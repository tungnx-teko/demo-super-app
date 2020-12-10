//
//  IMarketOrderError.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 9/14/20.
//

import Foundation

public protocol IMarketOrderError {
    var message: String? { get }
    var detail: String? { get }
    var details: [IMarketOrderErrorDetail] { get }
}

public protocol IMarketOrderErrorDetail {
    var code: String? { get }
    var message: String? { get }
    var orderId: String? { get }
}
