//
//  FBRemoteConfigService+Home.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation


public protocol FRCSHomeProtocol: class {
    var isShowBanner: Bool { get }
    var homeSections: [Firebase.HomeSection] { get }
}

// MARK: - Home config
extension FBRemoteConfigService: FRCSHomeProtocol {
    
    public var isShowBanner: Bool {
        return remoteConfig.configValue(forKey: homeSettingsPath.isShowBanner).boolValue
    }
    
    public var homeSections: [Firebase.HomeSection] {
        guard let homeSections = remoteConfig.configValue(forKey: homeSettingsPath.homeSections).jsonValue as? [[String: Any]] else {
            return []
        }
        return homeSections.compactMap { config in
            let visible = config[generalPath.visible] as? Bool ?? false
            let key = config[generalPath.key] as? String ?? ""
            let header = config[homeSettingsPath.header] as? String ?? ""
            return Firebase.HomeSection(visible: visible, key: key, header: header)
        }
    }
    
    public var homeSectionsVer2: [Firebase.HomeSection] {
        guard let homeSections = remoteConfig.configValue(forKey: homeSettingsPath.HomeSections).jsonValue as? [[String: Any]] else {
            return []
        }
        return homeSections.compactMap { config in
            let visible = config[generalPath.enabled] as? Bool ?? false
            let key = config[generalPath.key] as? String ?? ""
            let header = config[generalPath.title] as? String ?? ""
            let showTab = config[homeSettingsPath.showTab] as? Bool ?? false
            return Firebase.HomeSection(visible: visible, key: key, header: header, showTab: showTab)
        }
    }
}
