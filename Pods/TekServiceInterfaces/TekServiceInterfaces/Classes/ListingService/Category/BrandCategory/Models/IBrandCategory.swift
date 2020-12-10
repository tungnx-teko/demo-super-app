//
//  IBrandCategory.swift
//  VNShop
//
//  Created by Dung Nguyen on 12/16/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation

public protocol IBrandCategory {
    var id: Int { get }
    var name: String? { get }
    var codes: [String] { get }
    var configs: [String : Any]? { get }
    
}
