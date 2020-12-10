//
//  IFlashSale.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/1/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IFlashSale {
    var id: Int? { get }
    var type: String? { get }
    var discountPercent: Double? { get }
    var usedCount: Int? { get }
    var totalCount: Int? { get }
    var startTimestampSec: Double? { get }
    var endTimestampSec: Double? { get }
}
