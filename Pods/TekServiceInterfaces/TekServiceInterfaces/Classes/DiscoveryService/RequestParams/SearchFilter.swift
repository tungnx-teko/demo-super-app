//
//  SearchFilter.swift
//  VNShop
//
//  Created by Nguyen Xuan on 8/26/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public struct SearchFilter: Encodable {
    public var sellingCodes: [String]?
    public var priceGte: Int?
    public var priceLte: Int?
    public var brands: [String]?
    public var categories: [String]?
    public var tags: [String]?
    public var hasPromotions: Bool?
    public var attributes: [SearchAttribute]?
    public var providerIds: [String]?
    public var sellerIds: [String]?
    public var skus: [String]?
    public var flashSaleType: String?
    public var masterCategoryIds: [String]?
    public var excludedSkus: [String]?
    
    public init() {}
    
    public init(sellingCodes: [String]? = nil,
                priceGte: Int? = nil,
                priceLte: Int? = nil,
                brands: [String]? = nil,
                categories: [String]? = nil,
                tags: [String]? = nil,
                hasPromotions: Bool? = nil,
                attributes: [SearchAttribute]? = nil,
                providerIds: [String]? = nil,
                sellerIds: [String]? = nil,
                skus: [String]? = nil,
                flashSaleType: String? = nil,
                masterCategoryIds: [String]? = nil,
                excludedSkus: [String]? = nil) {
        self.sellingCodes = sellingCodes
        self.priceGte = priceGte
        self.priceLte = priceLte
        self.brands = brands
        self.categories = categories
        self.tags = tags
        self.hasPromotions = hasPromotions
        self.attributes = attributes
        self.providerIds = providerIds
        self.sellerIds = sellerIds
        self.skus = skus
        self.flashSaleType = flashSaleType
        self.masterCategoryIds = masterCategoryIds
        self.excludedSkus = excludedSkus
    }
}
