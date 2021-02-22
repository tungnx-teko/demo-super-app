//
//  DatabaseManager.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/25/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    var realm: Realm!
    
    private init() {
//        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
//                                                        appropriateFor: nil, create: false)
//        let url = documentDirectory.appendingPathComponent("app.realm")
        let config = Realm.Configuration(
//            fileURL: url,
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 16,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
            },
            
            objectTypes: [
                RealmUser.self
            ]
        )
        realm = try! Realm(configuration: config)
    }
    
    func getObjects<T: Object>(from objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
}
