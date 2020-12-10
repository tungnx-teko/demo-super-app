//
//  ProvinceWarehouse.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension Firebase {
    
    public struct ProvinceWarehouse {
        
        public var code: String?
        public var name: String = ""
        public var shippableProvinces: [ShippableProvince]
        public var storeCodes: [String]
        public var terminal: String?
        
    }
    
    public struct ShippableProvince {
        public var code: String?
        public var name: String = ""
        
    }
    
}
