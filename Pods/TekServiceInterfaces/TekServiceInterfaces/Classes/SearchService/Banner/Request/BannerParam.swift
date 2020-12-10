//
//  BannerParam.swift
//  VNShop
//
//  Created by tuananh on 2/25/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol BannerParamBuildable {
    func append(sorts: [[String : Any]]) -> BannerParamBuildable
    func append(filters: [[String : Any]]) -> BannerParamBuildable
    func append(pageSize: Int) -> BannerParamBuildable
    
    func build() -> BannerParam
}

public struct BannerParam {
    public var sorts: [[String : Any]] = []
    public var filters: [[String : Any]] = []
    public var pageSize: Int?
    
    public init() {}
    
    public init(campaignKey: String = "",
         sorts: [[String : Any]] = [],
         filters: [[String : Any]] = [],
         pageSize: Int? = nil) {
        self.sorts = sorts
        self.filters = filters
        self.pageSize = pageSize
    }
    
    public func toDict() -> [String : Any] {
        var params: [String : Any] = [:]
        params["sorts"] = sorts
        params["filters"] = filters
        if let pageSize = pageSize {
            params["page_size"] = pageSize
        }
        return params
    }
    
}

public class BannerParamBuilder: BannerParamBuildable {
    
    public var sorts: [[String : Any]] = []
    public var filters: [[String : Any]] = []
    public var pageSize: Int?
    
    public init() {}
    
    public func append(sorts: [[String : Any]]) -> BannerParamBuildable {
        self.sorts = sorts
        return self
    }
    
    public func append(filters: [[String : Any]]) -> BannerParamBuildable {
        self.filters = filters
        return self
    }
    
    public func append(pageSize: Int) -> BannerParamBuildable {
        self.pageSize = pageSize
        return self
    }
    
    public func build() -> BannerParam {
        return BannerParam(sorts: sorts, filters: filters, pageSize: pageSize)
    }
    
}


