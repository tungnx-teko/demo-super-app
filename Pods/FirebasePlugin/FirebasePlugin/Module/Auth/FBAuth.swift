//
//  FBAuth.swift
//  BLUE
//
//  Created by linhvt on 4/28/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import FirebaseAuth

public class FBAuth {
    
    public static func signIn(email: String, password: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        if Auth.auth().currentUser != nil {
            FBRemoteConfigService.shared.fetchRemoteConfig { (isSuccess) in
                completion(isSuccess)
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                FBRemoteConfigService.shared.fetchRemoteConfig { (isSuccess) in
                    completion(isSuccess)
                }
                
            }
        }
        
    }
    
    
}
