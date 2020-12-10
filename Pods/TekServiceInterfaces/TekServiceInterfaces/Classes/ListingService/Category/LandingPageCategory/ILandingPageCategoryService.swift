//
//  ILandingPageCategoryService.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by linhvt on 10/5/20.
//

import Foundation

public typealias LandingPageItemResponseHandler = (_ categories: [ICategory], _ isSuccess: Bool) -> Void

public protocol ILandingPageCategoryService {
    
    func getItemsForTopBanner(campaignKey: String, handler: @escaping LandingPageItemResponseHandler)
    
    func getItemsForDiscount(campaignKey: String, handler: @escaping LandingPageItemResponseHandler)
    
    func getItemsForBannerProducts(campaignKey: String, handler: @escaping LandingPageItemResponseHandler)
    
    func getItemsForAllProducts(campaignKey: String, handler: @escaping LandingPageItemResponseHandler)
}
