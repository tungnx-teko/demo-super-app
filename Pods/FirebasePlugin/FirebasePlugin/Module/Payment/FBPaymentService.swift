//
//  FBPaymentService.swift
//  BLUE
//
//  Created by Tung Nguyen on 12/4/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class FBPaymentService {
    
    public static let shared = FBPaymentService()
    
    var observingOrderId: String?
    
    init() {}
    
    public func registerObserving(orderId: String, transactionId: String, completion: @escaping (_ qrPayment: Firebase.QRPayment) -> Void) {
        self.observingOrderId = orderId
        Database
            .database()
            .reference(withPath: "order/payment/qr/\(orderId)")
            .observe(.childAdded) { snapshot in
                guard let dictionary = snapshot.value as? NSDictionary else { return }
                let payment = Firebase.QRPayment(fromDict: dictionary)
                if transactionId == payment.transactionId {
                    completion(payment)
                }
            }
    }
    
}
