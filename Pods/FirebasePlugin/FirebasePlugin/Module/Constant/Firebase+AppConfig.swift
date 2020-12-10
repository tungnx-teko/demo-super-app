//
//  Firebase+AppConfig.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

extension Firebase {
    
    public enum AppConfig {
        
        public static let channel          = FBRemoteConfigService.shared.channel
        public static let terminal         = FBRemoteConfigService.shared.terminal
        
        public static let clientCode       = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.clientCode) ?? ""
        public static let gms              = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.gms) ?? ""
        
        public static let hotline          = FBRemoteConfigService.shared.appConfigs[Firebase.Key.RemoteConfig.AppConfig.hotline]
        public static let policy           = FBRemoteConfigService.shared.appConfigs[Firebase.Key.RemoteConfig.AppConfig.policy]
        
        public enum TPay {
            public static let registerLink = FBRemoteConfigService.shared.appConfigs[Firebase.Key.RemoteConfig.AppConfig.tpayRegistration]
            public static let hotline      = FBRemoteConfigService.shared.appConfigs[Firebase.Key.RemoteConfig.AppConfig.tpayHotline]
            public static let policy       = FBRemoteConfigService.shared.appConfigs[Firebase.Key.RemoteConfig.AppConfig.tpayPolicy]
        }
        
        public static let blueConversionRate = FBRemoteConfigService.shared.appConfigs[Firebase.Key.RemoteConfig.AppConfig.blueConversionRate]
        
        public enum Tracker {
            
            public static let clientId     = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.trackerClientId) ?? ""

        }
        
        public enum OAuth {
            
            public static let clientId         = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.oauthClientId) ?? ""

        }
        
        public enum Loyalty {
            
            public static let clientId      = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.loyaltyClientId) ?? ""
            
        }
        
    }
    
}
