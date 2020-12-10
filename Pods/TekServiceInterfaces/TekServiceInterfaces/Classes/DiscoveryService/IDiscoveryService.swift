//
//  DiscoveryService.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 8/6/20.
//

import Foundation

public typealias BlockResponseHandler = (_ result: IBlockResult?, _ isSuccess: Bool) -> ()
public typealias SearchProductHandler = (_ result: IListing?, _ isSuccess: Bool) -> ()
public typealias GetProductDetailHandler = (_ product: IProduct?, _ isSuccess: Bool) -> ()
public typealias GetListProductDetailHandler = (_ products: [IProduct], _ isSuccess: Bool) -> ()
public typealias DiscoveryKeywordsResponseHandler = (_ keywords: [IDiscoveryKeyword], _ isSuccess: Bool, _ error: Error?) -> Void

public protocol IDiscoverySearchKeywordsService {
    func searchKeywords(query: String, completion: @escaping DiscoveryKeywordsResponseHandler)
}

public protocol IDiscoveryService: IDiscoverySearchKeywordsService {
    func blocks(userId: String?, phone: String?, pageType: String?, completion: @escaping BlockResponseHandler)
    func blocks(userId: String?, phone: String?, pageType: String?, category: String?, completion: @escaping BlockResponseHandler)
    func searchProducts(query: String,
                        block: SearchBlock,
                        filter: SearchFilter?,
                        sorting: SearchSorting?,
                        pagination: SearchPagination?,
                        location: String?,
                        returnFilterable: [ReturnFilterable],
                        userId: String?, phone: String?,
                        handler: @escaping SearchProductHandler)
    
    func getProductDetail(sku: String, location: String?, handler: @escaping GetProductDetailHandler)
    func getListProductDetail(skus: [String], location: String?, handler: @escaping GetListProductDetailHandler)
}

public extension IDiscoveryService {
    
    func getProductList(for block: SearchBlock,
                        filter: SearchFilter?,
                        sorting: SearchSorting?,
                        pagination: SearchPagination?,
                        userId: String? = nil, phone: String? = nil,
                        handler: @escaping SearchProductHandler) {
        searchProducts(query: "",
                       block: block,
                       filter: filter,
                       sorting: sorting,
                       pagination: pagination,
                       location: nil,
                       returnFilterable: [],
                       userId: userId,
                       phone: phone,
                       handler: handler)
    }
    
    func searchByKeyword(query: String,
                        for block: SearchBlock,
                        filter: SearchFilter?,
                        sorting: SearchSorting?,
                        pagination: SearchPagination?,
                        userId: String? = nil, phone: String? = nil,
                        handler: @escaping SearchProductHandler) {
        searchProducts(query: query,
                       block: block,
                       filter: filter,
                       sorting: sorting,
                       pagination: pagination,
                       location: nil,
                       returnFilterable: [],
                       userId: userId,
                       phone: phone,
                       handler: handler)

    }

    
}
