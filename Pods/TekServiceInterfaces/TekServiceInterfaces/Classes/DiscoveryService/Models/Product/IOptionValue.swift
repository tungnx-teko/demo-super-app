//
//  IOptionValue.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/2/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IOptionValue {
    var value: String? { get }
    var optionId: Int? { get }
    var images: [IOptionImage] { get }
}
