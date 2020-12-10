//
//  VNPayPromotion.swift
//  BLUE
//
//  Created by Le Vu Huy on 10/22/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation

public extension Firebase {
    
    public class VNPayPromotion {
        public var benefit: Firebase.VNPayPromotion.Benefit?
        public var coupon: String?
        public var date: Firebase.VNPayPromotion.FBDate?
        public var extraCondition: String?
        
        init(from dict: NSDictionary) {
            self.benefit = VNPayPromotion.Benefit(from: dict["benefit"] as? NSDictionary)
            self.coupon = dict["coupon"] as? String
            self.date = VNPayPromotion.FBDate(from: dict["date"] as? NSDictionary)
            self.extraCondition = dict["extraCondition"] as? String
        }
        
    }
    
    
}

extension Firebase.VNPayPromotion {
    
    public class FBDate {
        public var startDate: Date?
        public var endDate: Date?
        
        init(from dict: NSDictionary?) {
            self.startDate = (dict?["startDate"] as? String).flatMap { (Firebase.VNPayPromotion.FBDate.stringToDate(dateStr: $0)) }
            self.endDate = (dict?["endDate"] as? String).flatMap { (Firebase.VNPayPromotion.FBDate.stringToDate(dateStr: $0)) }
        }
        
        static func stringToDate(dateStr: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.date(from: dateStr)
        }
        
    }
    
    public class Benefit {
        public var discountPercent: Double?
        public var maxDiscount: Double?
        
        init(from dict: NSDictionary?) {
            self.discountPercent = dict?["discountPercent"] as? Double
            self.maxDiscount = dict?["maxDiscount"] as? Double
        }
        
    }
    
}
