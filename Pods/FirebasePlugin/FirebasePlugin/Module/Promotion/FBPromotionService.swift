//
//  FBPromotionService.swift
//  BLUE
//
//  Created by Le Vu Huy on 10/22/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import FirebaseDatabase

public class FBPromotionService {
    
    public init() {}
    
    
    public func getVNPayPromotion(completion: @escaping ([Firebase.VNPayPromotion]) -> ()) {
        let ref = Database.database().reference(withPath: "promotion/vnpay-promotion")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let promotions = snapshot.children.allObjects.compactMap { $0 as? DataSnapshot }
                .compactMap { child -> Firebase.VNPayPromotion? in
                    guard let dict = child.value as? NSDictionary else { return nil }
                    return Firebase.VNPayPromotion(from: dict)
            }
            .filter { promotion -> Bool in
                guard let startDate = promotion.date?.startDate, let endDate = promotion.date?.endDate, startDate < Date(), Date() < endDate else { return false }
                return true
            }
            
            completion(promotions)
        }
    }
    
}
