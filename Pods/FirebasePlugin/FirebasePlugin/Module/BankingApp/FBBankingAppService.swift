//
//  FBBankingAppService.swift
//  BLUE
//
//  Created by Tung Nguyen on 12/10/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class FBBankingAppService {
        
    public static let shared = FBBankingAppService()
    
    private init() { }

    public func getBankingApps(completion: @escaping ([Firebase.BankingApp]) -> ()) {
        Database
            .database()
            .reference(withPath: "banks")
            .observeSingleEvent(of: .value) { snapshot in
                let bankingApps = snapshot.children.allObjects.compactMap { $0 as? DataSnapshot }
                    .compactMap { child -> Firebase.BankingApp? in
                        guard let dict = child.value as? NSDictionary else { return nil }
                        return Firebase.BankingApp(from: dict)
                }
                completion(bankingApps)
            }
    }

}
