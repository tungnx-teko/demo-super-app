//
//  IServiceFee.swift
//  TekServiceInterfaces
//
//  Created by Nguyen Xuan on 11/27/20.
//

import Foundation

public protocol IServiceFee {
    var delivery: [IDeliveryFee] { get }
}

public protocol IDeliveryFee {
    var discountAmount: Double { get }
    var sellerId: Int? { get }
    var name: String { get }
    var price: Double { get }
    var rowTotal: Double { get }
}

