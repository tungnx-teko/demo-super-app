//
//  FBRemoteConfigService+Account.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol FRCSAccountProtocol: class {
    var accountSections: [[Firebase.AccountSection]] { get }
}

// MARK: - Account detail config
extension FBRemoteConfigService: FRCSAccountProtocol {
    
    public var accountSections: [[Firebase.AccountSection]] {
        guard let accountDetailSections = remoteConfig.configValue(forKey: accountDetailPath.accountDetailSections).jsonValue as? [[[String: Any]]] else {
            return []
        }
        return accountDetailSections.compactMap { group in
            return group.compactMap { item in
                let enabled = item[generalPath.enabled] as? Bool ?? false
                let key = item[generalPath.key] as? String ?? ""
                let editable = item[generalPath.editable] as? Bool ?? false
                return enabled ? Firebase.AccountSection(enabled: enabled, key: key, editable: editable) : nil
            }
        }
        
    }
    
//    func getAccountDetailSections(userInfo: UserInfoDTO?) -> [[AccountDetailCellType]] {
//        guard let accountDetailSections = remoteConfig.configValue(forKey: accountDetailPath.accountDetailSections).jsonValue as? [[[String: Any]]] else {
//            return []
//        }
//        return accountDetailSections.compactMap { group in
//            return group.compactMap { item in
//                let enabled = item[generalPath.enabled] as? Bool ?? false
//                let key = item[generalPath.key] as? String ?? ""
//                let editable = item[generalPath.editable] as? Bool ?? false
//                return enabled ? AccountDetailCellType.initialize(userInfo: userInfo, key: key, editable: editable) : nil
//            }
//        }
//    }
    
}
