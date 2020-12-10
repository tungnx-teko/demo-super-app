//
//  IBrandCategoryService.swift
//  VNShop
//
//  Created by Dung Nguyen on 12/16/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation

public typealias GetBrandCategoriesResponseHandler = (_ categories: [IBrandCategory], _ isSuccess: Bool) -> ()

public protocol ICategoryBrandService {
    
    func getCategories(displayCategoryId: Int, sort: [String], completion: @escaping GetBrandCategoriesResponseHandler)
    func getCategories(sellerCategories: [Int], completion: @escaping GetBrandCategoriesResponseHandler)
    
}
