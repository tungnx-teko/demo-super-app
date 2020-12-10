//
//  IPrice.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/1/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IPrice {
    var supplierRetailPrice: Double? { get }
    var terminalPrice: Double? { get }
    var latestPrice: Double? { get }
    var discountAmount: Double? { get }
    var discountPercent: Double? { get }
    var sellPrice: Double? { get }
}
