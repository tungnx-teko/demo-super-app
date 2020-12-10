//
//  EventRequestParamProtocol.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/8/20.
//

import Foundation

protocol EventRequestParamProtocol: Encodable {
    var originalID: String { get }

    var appID: String { get }
    var schemaVersion: String { get }
    var appVersion: String { get }
    var visitor: Visitor { get }
    var session: Session { get }
    var networkConnectivityInfo: NetworkConnectivityInfo { get }
    var timestamp: TimeInterval { get }
    var schemaName: String { get }
}
