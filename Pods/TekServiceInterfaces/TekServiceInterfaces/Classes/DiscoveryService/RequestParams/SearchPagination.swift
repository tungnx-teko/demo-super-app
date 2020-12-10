//
//  SearchPagination.swift
//  VNShop
//
//  Created by Nguyen Xuan on 8/26/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public struct SearchPagination: Encodable {
    public var pageNumber: Int
    public var itemsPerPage: Int
    
    public init() {
        pageNumber = 0
        itemsPerPage = 0
    }
    
    public init(pageNumber: Int, itemsPerPage: Int) {
        self.pageNumber = pageNumber
        self.itemsPerPage = itemsPerPage
    }
}
