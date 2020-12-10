//
//  ICondition.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/1/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol ICondition {
    var coupon: String? { get }
    var orderValueMin: Double? { get }
    var orderValueMax: Double? { get }
    var blockSize: Int? { get }
    var minQuantity: Int? { get }
}
