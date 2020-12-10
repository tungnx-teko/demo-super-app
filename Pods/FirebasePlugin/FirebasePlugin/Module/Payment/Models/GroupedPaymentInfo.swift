//
//  GroupedPaymentInfo.swift
//  FirebasePlugin
//
//  Created by linhvt on 4/29/20.
//

import Foundation

extension Firebase {
    
    public struct GroupedPaymentInfo {
        public var method: PaymentMethod?
        public var child: [ChildPaymentInfo] = []
        public var moreInfo: String
        public var promotions: [VNPayPromotion] = []
        
        init(method: String, child: [ChildPaymentInfo], moreInfo: String, promotions: [VNPayPromotion]) {
            self.method = PaymentMethod(rawValue: method)
            self.child = child
            self.moreInfo = moreInfo
            self.promotions = promotions
        }
    }
    
    public struct ChildPaymentInfo {
        public var method: PaymentMethod?
        public var moreInfo: String
        public var promotions: [VNPayPromotion] = []
        
        init(method: String, moreInfo: String, promotions: [VNPayPromotion]) {
            self.method = PaymentMethod(rawValue: method)
            self.moreInfo = moreInfo
            self.promotions = promotions
        }
    }
}
