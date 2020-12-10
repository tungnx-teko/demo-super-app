//
//  ILoyaltyBalance.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Thanh Bui Minh on 11/10/20.
//

import Foundation

public protocol ILoyaltyBalance {
    var status: Int { get }
    var statusDesc: String { get }
    var tokenBalance: Int { get }
}
