//
//  FBRemoteConfigService.swift
//  BLUE
//
//  Created by Dong Tuan Anh on 12/31/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseRemoteConfig

public protocol FRCSGeneralProtocol: class {
    var shippingSkus: [String] { get }
    var appStatus: Firebase.AppStatus { get }
    var env: Firebase.AppEnv { get }
    var appID: String? { get }
    var appIcon: String? { get }
    var isSupportAppScheme: Bool { get }
    var appConfigs: [String: String] { get }
    var theme: String? { get }
    var terminal: String? { get }
    var channel: String? { get }
    var shippingConfigs: [Firebase.ShippingConfig] { get }
    var isShowApple: Bool { get }
    var isShowFacebook: Bool { get }
    
    func getEnvValue(key: String) -> String?
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void)
}

// MARK: - General config from firebase like app config, env, shippingSku
public class FBRemoteConfigService: FRCSGeneralProtocol {
    
    public static let shared = FBRemoteConfigService()
    public var isConfigLoaded: Bool = false
    var remoteConfig: RemoteConfig!
    let expirationDuration = 3600;
    
    
    // MARK: - path
    internal let remoteConfigPath            = Firebase.Key.RemoteConfig.self
    internal let generalPath                 = Firebase.Key.RemoteConfig.General.self
    internal let envPath                     = Firebase.Key.RemoteConfig.Env.self
    internal let homeSettingsPath            = Firebase.Key.RemoteConfig.HomeSetting.self
    internal let accountDetailPath           = Firebase.Key.RemoteConfig.AccountDetail.self
    
    // MARK: - init
    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.fetchTimeout = 15
        settings.minimumFetchInterval = 60
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    // MARK: - public values
    public var appStatus: Firebase.AppStatus {
        let status = remoteConfig.configValue(forKey: remoteConfigPath.appStatus).stringValue
        return Firebase.AppStatus.getAppStatus(appStatus: status)
    }
    
    public var env: Firebase.AppEnv {
        if appStatus == .inReview {
            return .inReview
        }
        let env = remoteConfig.configValue(forKey: remoteConfigPath.env).stringValue
        return Firebase.AppEnv.getAppEnv(env: env)
    }
    
    public var theme: String? {
        let themeName = remoteConfig.configValue(forKey: remoteConfigPath.themeName).stringValue
        return themeName
    }
    
    public var appID: String? {
        return remoteConfig.configValue(forKey: remoteConfigPath.appID).stringValue
    }
    
    public var terminal: String? {
        let terminal = remoteConfig.configValue(forKey: remoteConfigPath.terminal).stringValue
        return terminal
    }
    
    public var channel: String? {
        let channel = remoteConfig.configValue(forKey: remoteConfigPath.channel).stringValue
        return channel
    }
    
    public var appIcon: String? {
        return remoteConfig.configValue(forKey: remoteConfigPath.appIcon).stringValue
    }
    
    public var isSupportAppScheme: Bool {
        return remoteConfig.configValue(forKey: remoteConfigPath.isSupportAppScheme).boolValue
    }
    
    public var shippingConfigs: [Firebase.ShippingConfig] {
        guard let listConfigs = remoteConfig.configValue(forKey: generalPath.shippingConfig).jsonValue as? [[String: Any]] else {
            return []
        }
        return listConfigs.compactMap { config -> Firebase.ShippingConfig in
            let sellerId = config[generalPath.sellerId] as? Int32 ?? 0
            let shippingFee = config[generalPath.shippingFee] as? Double ?? 0
            let shippingSku = config[generalPath.shippingFeeSku] as? String
            let freeShippingMilestone = config[generalPath.freeShippingMilestone] as? Double ?? Double.infinity
            let shippingItemName = config[generalPath.shippingItemName] as? String
            return Firebase.ShippingConfig(sellerId: sellerId,
                                           shippingFee: shippingFee,
                                           shippingSku: shippingSku,
                                           freeShippingMilestone: freeShippingMilestone,
                                           shippingItemName: shippingItemName)
        }
    }
    
    public var shippingSkus: [String] {
        guard let listConfigs = remoteConfig.configValue(forKey: generalPath.shippingConfig).jsonValue as? [[String: Any]] else {
            return []
        }
        return listConfigs.compactMap { dict in
            if let shippingSku = dict[generalPath.shippingFeeSku] as? String {
                return shippingSku
            } else {
                return nil
            }
        }
    }
    
    public var isShowApple: Bool {
        return remoteConfig.configValue(forKey: "isShowApple").boolValue
    }
    
    public var isShowFacebook: Bool {
        return remoteConfig.configValue(forKey: "isShowFB").boolValue
    }
    
    public var feedbackNumber: Int {
        guard let number = remoteConfig.configValue(forKey: remoteConfigPath.feedbackNumber).numberValue?.intValue else {
            return 0
        }
        return number
    }
    
    public var appConfigs: [String: String] {
        guard let configs = remoteConfig.configValue(forKey: remoteConfigPath.appConfigs).jsonValue as? [String: String] else {
            return [:]
        }
        return configs
    }
    
    public func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        remoteConfig.fetch(withExpirationDuration: 1.0) { [weak self] (status, error) in
            if status == .success {
                print("Config fetched!")
                self?.remoteConfig.activate { (error) in
                    if error == nil {
                        print("Config activate success")
                        self?.isConfigLoaded = true
                        completion(true)
                    } else {
                        print("Config activate failed " + (error?.localizedDescription ?? "unknown error"))
                        self?.isConfigLoaded = true
                        completion(true)
                    }
                }
            } else {
                print("Config fetch failed " + (error?.localizedDescription ?? "unknown error"))
                self?.isConfigLoaded = false
                completion(false)
            }
        }
    }
    
    public func getEnvValue(key: String) -> String? {
        guard let json = remoteConfig.configValue(forKey: env.value).jsonValue as? [String: String] else {
            return nil
        }
        return json[key]
    }
    
}
