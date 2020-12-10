//
//  FBSellerService.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import FirebaseDatabase

public class FBSellerService {
    
    public init() {}

    public func getSellers(completion: @escaping (_ sellers: [Firebase.Seller]) -> Void) {
        let ref = Database.database().reference(withPath: "seller")
        ref.observeSingleEvent(of: .value) { snapshot in
            
            let sellers = snapshot.children
                .compactMap { return ($0 as? DataSnapshot) }
                .compactMap { return self.constructSellerList(from: $0) }
            
            completion(sellers)
        }
    }
    
    private func constructSellerList(from snap: DataSnapshot) -> Firebase.Seller? {
        if let seller = snap.value as? [String: Any],
            let sellerId = seller["id"] as? Int {
            let fbLogisRule = seller["logis_rule"] as? String
            let logisRules = getLogisRules(logisRuleParams: snap.childSnapshot(forPath: "logis_rule_params"))
            let fbLogoUrl = seller["logo"] as? String
            let logoURL = URL(string: fbLogoUrl ?? "")
            let name = seller["name"] as? String
            let displayName = seller["displayName"] as? String
            let slogan = seller["slogan"] as? String
            let sloganShipping = seller["slogan_shipping"] as? String
            let isVerified = seller["verified"] as? Bool ?? false
            let policies = constructPolicyApp(policyApp: snap.childSnapshot(forPath: "policy_app"))
            let shippingProvincesLimit = constructShippingProvincesLimit(shippingLimit: snap.childSnapshot(forPath: "shipping_provinces_limit_in"))
            let services = seller["services"] as? [String: Any]
            let shippingLimitationMsg = services?["shipping_limit_alert"] as? String
            let supportFastDelivery = services?["support_2hdeliver"] as? Bool ?? true
            let provinces = getProvinceWarehouseList(provincesSnapshot: snap.childSnapshot(forPath: "warehouses"))
            let categorySeller = Firebase.Seller(logoURL: logoURL,
                                                 name: name,
                                                 displayName: displayName,
                                                 slogan: slogan,
                                                 sloganShipping: sloganShipping,
                                                 policies: policies,
                                                 logisBaseString: fbLogisRule,
                                                 logisRules: logisRules,
                                                 verified: isVerified,
                                                 id: sellerId,
                                                 shippingProvincesLimit: shippingProvincesLimit,
                                                 shippingLimitationMsg: shippingLimitationMsg,
                                                 supportFastDelivery: supportFastDelivery,
                                                 provinces: provinces)
            return categorySeller
        }
        return nil
    }
    
    private func getLogisRules(logisRuleParams: DataSnapshot) -> [Any] {
        var rules: [Any] = []
        for child in logisRuleParams.children {
            if let snap = child as? DataSnapshot {
                if let numberValue = snap.value as? Double {
                    rules.append(numberValue)
                } else if let stringValue = snap.value as? String {
                    rules.append(stringValue)
                }
            }
        }
        
        return rules
    }
    
    private func getProvinceWarehouseList(provincesSnapshot: DataSnapshot) -> [Firebase.ProvinceWarehouse] {
        var provinces: [Firebase.ProvinceWarehouse] = []
        for child in provincesSnapshot.children {
            if let snap = child as? DataSnapshot,
                let snapDict = snap.value as? [String: Any] {
                let province = constructProvinceWarehouse(provinceSnapshot: snap, snap: snapDict)
                provinces.append(province)
            }
        }
        return provinces
    }
    
    private func constructProvinceWarehouse(provinceSnapshot: DataSnapshot, snap: [String: Any]) -> Firebase.ProvinceWarehouse {
        let code = snap["code"] as? String
        let name = snap["name"] as? String ?? ""
        let systemTerminal = snap["terminal"] as? [String: Any]
        let terminal = systemTerminal?["ios"] as? String
        let shippableProvinces = constructShippableProvinces(shippableProvincesSnapshot: provinceSnapshot.childSnapshot(forPath: "shippable_provinces"))
        let storeCodes: [String] = constructStoreCodes(storeCodeSnapshot: provinceSnapshot.childSnapshot(forPath: "store_codes"))
        return Firebase.ProvinceWarehouse(code: code, name: name,
                                 shippableProvinces: shippableProvinces, storeCodes: storeCodes,
                                 terminal: terminal)
    }
    
    private func constructShippableProvinces(shippableProvincesSnapshot: DataSnapshot) -> [Firebase.ShippableProvince] {
        var shippableProvinces: [Firebase.ShippableProvince] = []
        for child in shippableProvincesSnapshot.children {
            if let snap = child as? DataSnapshot,
                let shippableProvinceDict = snap.value as? [String: Any] {
                let code = shippableProvinceDict["code"] as? String
                let name = shippableProvinceDict["name"] as? String ?? ""
                let shippableProvince = Firebase.ShippableProvince(code: code, name: name)
                shippableProvinces.append(shippableProvince)
            }
        }
        return shippableProvinces
    }
    
    private func constructStoreCodes(storeCodeSnapshot: DataSnapshot) -> [String] {
        var storeCodes: [String] = []
        for child in storeCodeSnapshot.children {
            if let snap = child as? DataSnapshot,
                let code = snap.value as? String {
                storeCodes.append(code)
            }
        }
        return storeCodes
    }
    
    private func constructPolicyApp(policyApp: DataSnapshot) -> [Firebase.SellerPolicy] {
        policyApp.children.compactMap { child in
            guard let snap = child as? DataSnapshot, let policy = snap.value as? [String: Any] else {
                return nil
            }
            let icon = policy["icon"] as? String ?? ""
            let text = policy["text"] as? String ?? ""
            return Firebase.SellerPolicy(iconUrl: URL(string: icon), title: text)
        }
    }
    
    private func constructShippingProvincesLimit(shippingLimit: DataSnapshot) -> [Firebase.SellerProvince] {
        shippingLimit.children.compactMap { child in
            guard let snap = child as? DataSnapshot, let province = snap.value as? [String: Any] else {
                return nil
            }
            let code = province["code"] as? String ?? ""
            let name = province["name"] as? String ?? ""
            return Firebase.SellerProvince(code: code, name: name)
        }
    }
    
    public func fetchConsumerOption(completion: @escaping (_ consumerOption: ConsumerOption?) -> Void) {
        let ref = Database.database().reference(withPath: "option")
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let snapshotValue = snapshot.value as? [String: AnyObject] else {
                completion(nil)
                return
            }
            let consumerOption = ConsumerOption(snapshotValue)
            completion(consumerOption)
        }
    }
    
    
}
