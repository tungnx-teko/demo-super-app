//
//  ICategoryService.swift
//  VNShop
//
//  Created by Dung Nguyen on 12/16/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation

public enum CategoryZone: String {
    case topBrand = "top_brand"
    case topCategory = "top_category"
    case mobileCategory = "mobile-category"
    case newSeller = "new_seller_home"
    case customCategory = "custom_category"
}

public typealias GetCategoriesResponseHandler = (_ categories: [ICategory], _ isSuccess: Bool) -> ()

public protocol ICategoryService {
    func getCategories(page: Int, limit: Int, sorts: [String], orders: [String], level: Int, parentId: Int?, completion: @escaping GetCategoriesResponseHandler)
    func getTopCategories(page: Int, limit: Int, sorts: [String], orders: [String], level: Int, parentId: Int?, zone: CategoryZone?, completion: @escaping GetCategoriesResponseHandler)
    
}
