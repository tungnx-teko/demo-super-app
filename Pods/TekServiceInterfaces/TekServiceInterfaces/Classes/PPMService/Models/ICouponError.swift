//
//  ICouponError.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/14/20.
//

import Foundation

public protocol ICouponError {
    var coupon: String? { get }
    var code: String? { get }
    var message: String? { get }
}
