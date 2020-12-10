//
//  Firebase+AppStatus.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

extension Firebase {
    
    public enum AppStatus: String {

         case dev
         case test
         case inReview
         case live
         case update
         case off
         
         var value: String {
             return self.rawValue
         }
         
         static func getAppStatus(appStatus: String?) -> AppStatus {
             guard let rawValue = appStatus else { return .off }
             return AppStatus(rawValue: rawValue) ?? .off
         }
         
     }
    
}
