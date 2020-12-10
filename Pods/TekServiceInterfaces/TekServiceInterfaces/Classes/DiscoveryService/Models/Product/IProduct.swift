//
//  Protocols.swift
//  Discovery
//
//  Created by Nguyen Xuan on 8/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IProduct {
    var productInfo: IInfo? { get }
    var promotions: [IProductPromotion] { get }
    var totalAvailable: Double? { get }
    var prices: [IPrice] { get }
    var flashSales: [IFlashSale] { get }
    var productDetail: IDetail? { get }
    var provider: IProvider? { get }
}

