//
//  RealmUser.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/25/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmUser: Object {
    @objc dynamic var logoUrl: String?
    @objc dynamic var name: String?
    @objc dynamic var displayName: String?
    @objc dynamic var slogan: String?
    @objc dynamic var sloganShipping: String?
    @objc dynamic var logisRule: String?
    @objc dynamic var verified: Bool = false
    @objc dynamic var id: Int32 = 0
    @objc dynamic var shippingLimitationMsg: String?
    
    required override init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
