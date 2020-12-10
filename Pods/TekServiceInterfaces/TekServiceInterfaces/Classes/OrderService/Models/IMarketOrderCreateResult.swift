//
//  IMarketOrderCreateResult.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 9/14/20.
//

import Foundation

public protocol IMarketOrderCreateResult {
    var id: String? { get }
    var code: String? { get }
    var state: String? { get }
    var childOrders: [IMarketChildOrder] { get }
    var items: [IOrderItem] { get }
    var grandTotal: Double? { get }
}
