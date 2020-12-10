//
//  ISeller.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/2/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol ISeller {
    var id: Int? { get }
    var name: String? { get }
    var displayName: String? { get }
}
