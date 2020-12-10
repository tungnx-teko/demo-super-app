//
//  FBRemoteConfigService+Payment.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

protocol FRCSPaymentProtocol: class {
    var paymentList: [Firebase.PaymentMethod] { get }
    var groupedPaymentMethods: [Firebase.GroupedPaymentInfo] { get }
}

// MARK: - Payment config
extension FBRemoteConfigService: FRCSPaymentProtocol {
    
    public var paymentList: [Firebase.PaymentMethod] {
        let stringList: [String] = remoteConfig.configValue(forKey: remoteConfigPath.paymentList).jsonValue as? [String] ?? []
        let fbPaymentList: [Firebase.PaymentMethod] = stringList.compactMap { Firebase.PaymentMethod(rawValue: $0) }
        return fbPaymentList
    }
    
    public var groupedPaymentMethods: [Firebase.GroupedPaymentInfo] {
        guard let groupedPaymentList = remoteConfig.configValue(forKey: "groupedPaymentMethods").jsonValue as? [[String: Any]] else {
            return []
        }
        let groupedPaymentInfos = groupedPaymentList.map { item -> Firebase.GroupedPaymentInfo in
            let method = item["method"] as? String ?? ""
            let child = item["child"] as? [[String: Any]] ?? []
            let childPayments = child.map { childItem -> Firebase.ChildPaymentInfo in
                let method = childItem["method"] as? String ?? ""
                let moreInfo = childItem["childItem"] as? String ?? ""
                return Firebase.ChildPaymentInfo(method: method, moreInfo: moreInfo, promotions: [])
            }
            let moreInfo = item["moreInfo"] as? String ?? ""
            return Firebase.GroupedPaymentInfo(method: method, child: childPayments, moreInfo: moreInfo, promotions: [])
        }
        return groupedPaymentInfos
    }
    
}
