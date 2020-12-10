//
//  Firebase+Url.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

extension Firebase {
    
    public enum Url {
        
        public static let listing      = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.api)
        public static let search       = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.search)
        public static let crm          = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.crm)
        public static let order        = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.order)
        public static let promotions   = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.promotions)
        public static let catalog      = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.catalog)
        public static let iam          = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.iam)
        public static let payment      = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.payment)
        public static let address      = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.address)
        public static let user         = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.user)
        public static let image        = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.image)
        public static let notification = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.notification)
        public static let pageBuilder  = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.pageBuilder)
        public static let oAuth        = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.oAuth)
        public static let identity     = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.identity)
        public static let loyalty      = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.loyalty)
        public static let discovery    = FBRemoteConfigService.shared.getEnvValue(key: Firebase.Key.RemoteConfig.Env.discovery)
    }
    
}
