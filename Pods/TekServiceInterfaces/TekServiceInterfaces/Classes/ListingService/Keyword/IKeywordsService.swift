//
//  IKeywordsService.swift
//  VNShop
//
//  Created by linhvt on 11/6/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation

public typealias KeywordsResponseHandler = (_ keywords: [IKeyword], _ isSuccess: Bool, _ error: Error?) -> Void

public protocol IPopularKeywordsService {
    func getPopularKeywords(visitorId: String?, completion: @escaping KeywordsResponseHandler)
}

public protocol ISearchKeywordsService {
    func searchKeywords(query: String, page: Int, visitorId: String?, completion: @escaping KeywordsResponseHandler)
}

public protocol IKeywordsService: IPopularKeywordsService, ISearchKeywordsService {}
