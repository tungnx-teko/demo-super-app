//
//  IGroupConfig.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/2/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IGroupConfig {
    var id: Int? { get }
    var code: String? { get }
    var name: String? { get }
    var optionType: String? { get }
    var options: [IOptionValue] { get }
}
