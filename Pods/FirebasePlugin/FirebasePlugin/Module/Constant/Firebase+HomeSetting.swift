//
//  Firebase+HomeSetting.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension Firebase {
    
    public enum HomeSetting {
        
        public static let bannerToken = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.HomeSetting.tokenBannerHome) ?? ""
        
        
    }
    
}
