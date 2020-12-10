//
//  Firebase+AppEnv.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

extension Firebase {
    
    public enum AppEnv: String {
        
        case dev
        case test
        case staging
        case inReview
        case live
        
        var value: String {
            return self.rawValue
        }
        
        static func getAppEnv(env: String?) -> AppEnv {
            guard let rawValue = env else { return .inReview }
            return AppEnv(rawValue: rawValue) ?? .inReview
        }
        
    }
    
}
