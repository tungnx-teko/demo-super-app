//
//  SearchEvent.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

final public class SearchEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var params: Params
    @objc public var keywords: [String]
    @objc public var sort: [String]
    @objc public var order: [String]

    enum CodingKeys: String, CodingKey {
        case params, keywords, sort, order
    }

    @objc public init(params: Params, keywords: [String] = [], sort: [String] = [], order: [String] = []) {
        self.params = params
        self.keywords = keywords
        self.sort = sort
        self.order = order
        super.init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let paramData = try JSONEncoder().encode(params)
        try container.encode(String(data: paramData, encoding: .utf8), forKey: .params)
        if keywords.isEmpty {
            try container.encode(" ", forKey: .keywords)
        } else {
            try container.encode(keywords.joined(separator: ","), forKey: .keywords)
        }
        if !sort.isEmpty {
            try container.encode(sort.joined(separator: ","), forKey: .sort)
        }
        if !order.isEmpty {
            try container.encode(order.joined(separator: ","), forKey: .order)
        }
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension SearchEventData {
    @objc(SearchParams)
    final public class Params: NSObject, Encodable {
        @objc public var channel: String
        @objc public var terminal: String
        @objc public var keyword: String
        @objc public var page: Int
        @objc public var limit: Int
        public var minPrice: Double?

        @available(*, message: "Unavailable in Swift", unavailable)
        @objc(minPrice)
        public var objcMinPrice: NSNumber? {
            set { minPrice = newValue?.doubleValue }
            get { minPrice as NSNumber? }
        }

        public var maxPrice: Double?

        @available(*, message: "Unavailable in Swift", unavailable)
        @objc(maxPrice)
        public var objcMaxPrice: NSNumber? {
            set { maxPrice = newValue?.doubleValue }
            get { maxPrice as NSNumber? }
        }

        @objc public var objectives: [String]
        @objc public var productLines: [String]
        @objc public var saleStatuses: [String]
        /// Brand codes
        @objc public var brands: [String]
        /// Category IDs
        @objc public var categories: [String]
        @objc public var saleCategories: [String]
        @objc public var attributeSets: [String]
        @objc public var hasPromotions: Bool

        enum CodingKeys: String, CodingKey {
            case channel, terminal
            case keyword = "q"
            case page = "_page"
            case limit = "_limit"
            case minPrice = "price_lte"
            case maxPrice = "price_gte"
            case objectives, productLines, saleStatuses, brands, categories, saleCategories, attributeSets, hasPromotions
        }

        public init(channel: String, terminal: String, keyword: String = "", page: Int, limit: Int, minPrice: Double? = nil, maxPrice: Double? = nil, objectives: [String] = [], productLines: [String] = [], saleStatuses: [String] = [], brands: [String] = [], categories: [String] = [], saleCategories: [String] = [], attributeSets: [String] = [], hasPromotions: Bool = false) {
            self.channel = channel
            self.terminal = terminal
            self.keyword = keyword
            self.page = page
            self.limit = limit
            self.minPrice = minPrice
            self.maxPrice = maxPrice
            self.objectives = objectives
            self.productLines = productLines
            self.saleStatuses = saleStatuses
            self.brands = brands
            self.categories = categories
            self.saleCategories = saleCategories
            self.attributeSets = attributeSets
            self.hasPromotions = hasPromotions
            super.init()
        }

        @available(*, message: "Unavailable in Swift", unavailable)
        @objc public init(channel: String, terminal: String, keyword: String, page: Int, limit: Int, sort: [String], order: [String], minPrice: NSNumber?, maxPrice: NSNumber?, objectives: [String], productLines: [String], saleStatuses: [String], brands: [String], categories: [String], saleCategories: [String], attributeSets: [String], hasPromotions: Bool) {
            self.channel = channel
            self.terminal = terminal
            self.keyword = keyword
            self.page = page
            self.limit = limit
            self.minPrice = minPrice?.doubleValue
            self.maxPrice = maxPrice?.doubleValue
            self.objectives = objectives
            self.productLines = productLines
            self.saleStatuses = saleStatuses
            self.brands = brands
            self.categories = categories
            self.saleCategories = saleCategories
            self.attributeSets = attributeSets
            self.hasPromotions = hasPromotions
            super.init()
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(channel, forKey: .channel)
            try container.encode(terminal, forKey: .terminal)
            try container.encode(keyword, forKey: .keyword)
            try container.encode(page, forKey: .page)
            try container.encode(limit, forKey: .limit)
            try container.encodeIfPresent(minPrice, forKey: .minPrice)
            try container.encodeIfPresent(maxPrice, forKey: .maxPrice)
            if !objectives.isEmpty {
                try container.encode(objectives, forKey: .objectives)
            }
            if !productLines.isEmpty {
                try container.encode(productLines, forKey: .productLines)
            }
            if !saleStatuses.isEmpty {
                try container.encode(saleStatuses, forKey: .saleStatuses)
            }
            if !brands.isEmpty {
                try container.encode(brands, forKey: .brands)
            }
            if !categories.isEmpty {
                try container.encode(categories, forKey: .categories)
            }
            if !saleCategories.isEmpty {
                try container.encode(saleCategories, forKey: .saleCategories)
            }
            if !attributeSets.isEmpty {
                try container.encode(attributeSets, forKey: .attributeSets)
            }
            try container.encode(hasPromotions, forKey: .hasPromotions)
        }
    }
}
