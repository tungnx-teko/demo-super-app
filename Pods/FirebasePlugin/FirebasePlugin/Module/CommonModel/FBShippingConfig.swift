//
//  FBShippingConfig.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension Firebase {
    
    public struct ShippingConfig {
        
        public var sellerId: Int32
        public var shippingFee: Double
        public var shippingSku: String?
        public var freeShippingMilestone: Double
        public var shippingItemName: String?

    }
    
}
