//
//  IPromotion.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/1/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IPromotion {
    var id: Int? { get }
    var isDefault: Bool { get }
    var applyOn: String? { get }
    var description: String? { get }
    var name: String? { get }
}
