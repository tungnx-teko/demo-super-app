//
//  Seller.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation


extension Firebase {
    
    public struct SellerProvince {
        public var code: String = ""
        public var name: String = ""
        
        public init(code: String, name: String) {
            self.code = code
            self.name = name
        }
    }
    
    public struct SellerPolicy {
        
        public var title: String = ""
        public var iconUrl: URL? = nil
        
        public init(iconUrl: URL?, title: String) {
            self.iconUrl = iconUrl
            self.title = title
        }
    }
    
    public class Seller {
        public var logoURL: URL?
        public var name: String?
        public var displayName: String?
        public var slogan: String?
        public var sloganShipping: String?
        public var policies: [SellerPolicy] = []
        public var logisBaseString: String?
        public var logisRules: [Any]
        public var verified: Bool
        public var id: Int32
        public var shippingProvincesLimit: [SellerProvince] = []
        public var shippingLimitationMsg: String?
        public var supportFastDelivery: Bool = false
        public var provinceWarehouseList: [ProvinceWarehouse] = []
        
        init(logoURL: URL?,
             name: String?,
             displayName: String?,
             slogan: String?,
             sloganShipping: String? = nil,
             policies: [SellerPolicy],
             logisBaseString: String?,
             logisRules: [Any],
             verified: Bool,
             id: Int,
             shippingProvincesLimit: [SellerProvince] = [],
             shippingLimitationMsg: String?,
             supportFastDelivery: Bool = false,
             provinces: [ProvinceWarehouse] = []) {
            
            self.logoURL = logoURL
            self.name = name
            self.displayName = displayName
            self.slogan = slogan
            self.sloganShipping = sloganShipping
            self.policies = policies
            self.logisBaseString = logisBaseString
            self.logisRules = logisRules
            self.verified = verified
            self.id = Int32(id)
            self.shippingProvincesLimit = shippingProvincesLimit
            self.shippingLimitationMsg = shippingLimitationMsg
            self.supportFastDelivery = supportFastDelivery
            self.provinceWarehouseList = provinces
        }
        
    }
    
    
    
}
