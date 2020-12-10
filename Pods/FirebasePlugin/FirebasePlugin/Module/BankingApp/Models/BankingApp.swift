//
//  BankingApp.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public extension Firebase {
    
    struct BankingApp {
        public var alias: String?
        public var code: String?
        public var appIcon: String?
        public var webIcon: String?
        public var logo: String?
        public var scheme: String?
        public var name: String?
        public var package: String?
        public var isSupportDeeplink: Bool = false
        public var supportATM: Bool = false
        public var lastUsedDate: Date?
        public var type: BankType
        
        public init(from dict: NSDictionary) {
            self.alias = dict["alias"] as? String
            self.code = dict["code"] as? String
            self.appIcon = dict["logo_app"] as? String
            self.webIcon = dict["logo_web"] as? String
            self.logo = dict["logo"] as? String
            self.scheme = dict["mobile_app"] as? String
            self.name = dict["name"] as? String
            self.package = dict["package"] as? String
            self.isSupportDeeplink = (dict["support_deeplink"] as? Bool) ?? false
            self.supportATM = (dict["support_atm"] as? Bool) ?? false
            self.type = (dict["type"] as? String).flatMap(BankType.init) ?? .bank
        }
        
    }
        
        
}
