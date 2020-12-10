//
//  SearchAttribute.swift
//  VNShop
//
//  Created by Nguyen Xuan on 8/26/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public struct SearchAttribute: Encodable {
    public var code: String?
    public var optionIds: [String]?
    
    public init() {}
    
    public init(code: String? = nil, optionIds: [String]? = nil) {
        self.code = code
        self.optionIds = optionIds
    }
}
