//
//  IMoney.swift
//  PPMServiceInterface
//
//  Created by Tung Nguyen on 8/4/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public protocol IMoney {
    var id: Int { get }
    var flat: Double? { get }
    var percent: Double? { get }
    var maxAmount: Double? { get }
    var maxAmountPerOrder: Double? { get }
}
