//
//  Firebase+PaymentMethod.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

extension Firebase {
    
    public enum BankType: String {
        case bank
        case wallet
        case internationalCard = "international_card"
    }
    
    public enum PaymentMethod: String {
        
        case tpay = "TPAY"
        case mobileBanking = "MB"
        case vnpayQR = "VNPAYQR"
        case atm = "ATM"
        case card = "CARD"
        case cod = "COD"
        case vnpay = "VNPAY"
        
    }
    
    public enum Payment {
        public  static let secretKey    = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.paymentSecretKey) ?? ""
        public  static let clientCode   = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.paymentClientCode) ?? ""
        public  static let terminalCode = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.paymentTerminalCode) ?? ""
    }
    
}
