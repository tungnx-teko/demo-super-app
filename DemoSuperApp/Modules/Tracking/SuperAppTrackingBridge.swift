//
//  TrackingBridge.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/10/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import TrackingBridge
import SwiftGRPC

class SuperAppTrackingBridge: TrackingBridgeProtocol {
    
    func trackAppEvent(appId: String, eventType: String, data: [String : Any]) {
        print("[Tracking] \(appId) - \(eventType)\n")
        print(data)
    
    }
    
}
