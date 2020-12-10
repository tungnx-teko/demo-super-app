//
//  QRPayment.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension Firebase {
    
    public struct QRPayment {
        public var amount: Double?
        public var message: String?
        public var ref: String?
        public var status: String?
        public var transactionId: String?
        
        public var isSuccess: Bool {
            return status == "000"
        }
        
        init(fromDict dict: NSDictionary) {
            self.amount = dict["amount"] as? Double
            self.message = dict["message"] as? String
            self.ref = dict["ref"] as? String
            self.status = dict["status"] as? String
            self.transactionId = dict["transaction_id"] as? String
        }
    }
    
}
