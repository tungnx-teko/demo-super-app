//
//  IPPMService.swift
//  PPMServiceInterface
//
//  Created by Tung Nguyen on 8/4/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public typealias GetOrderPromotionsHandler = ([IDefinition], Bool) -> Void
public typealias ValidateCouponHandler = ([IDefinition], [ICouponError], Bool, Error?) -> Void

public protocol IPpmService {
    func getOrderPromotions(completion: @escaping GetOrderPromotionsHandler)
    func validateCoupon(_ coupon: String, skus: [String], completion: @escaping ValidateCouponHandler)
}
