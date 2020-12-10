//
//  IProvider.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/2/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IProvider {
    var id: Int? { get }
    var name: String? { get }
    var slogan: String? { get }
    var logo: String? { get }
}
