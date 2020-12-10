//
//  SearchSorting.swift
//  VNShop
//
//  Created by Nguyen Xuan on 8/26/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public struct SearchSorting: Encodable {
    public var sort: String?
    public var order: String?
    
    public init() {}
    
    public init(sort: String? = nil, order: String? = nil) {
        self.sort = sort
        self.order = order
    }
}
