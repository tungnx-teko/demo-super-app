//
//  ICategory.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/2/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol ICategory {
    var code: String? { get }
    var name: String? { get }
    var id: Int { get }
    var parentId: Int? { get }
    var icon: String? { get }
    var configs: [String: Any]? { get }
    var level: Int? { get }
    var sellerCategories: [Int] { get }
    var urlType: String? { get }
    var targetPath: String? { get }
    var url: String? { get }
    var blockParams: IBlockParams? { get }

}
