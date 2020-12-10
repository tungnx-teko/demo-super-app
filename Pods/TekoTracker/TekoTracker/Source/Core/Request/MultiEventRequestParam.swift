//
//  MultiEventRequest.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/7/20.
//

import Foundation

struct MultiEventRequestParam: EventRequestParamProtocol {
    let originalID: String
    let appID: String
    let schemaVersion: String
    let appVersion: String
    let visitor: Visitor
    let session: Session
    let networkConnectivityInfo: NetworkConnectivityInfo
    let events: [Event]
    let timestamp: TimeInterval
    let schemaName: String

    enum CodingKeys: String, CodingKey {
        case visitor, session, schemaName
        case events = "event"
        case appID = "appId"
        case schemaVersion = "schemaVer"
        case appVersion = "clientVersion"
        case networkConnectivityInfo = "network"
        case timestamp = "stm"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appID, forKey: .appID)
        try container.encode(schemaVersion, forKey: .schemaVersion)
        try container.encode(appVersion, forKey: .appVersion)
        try container.encode(visitor, forKey: .visitor)
        try container.encode(session, forKey: .session)
        try container.encode(networkConnectivityInfo, forKey: .networkConnectivityInfo)
        try container.encode(events, forKey: .events)
        try container.encode(Int64(timestamp * 1000), forKey: .timestamp)
        try container.encode(schemaName, forKey: .schemaName)
    }
}

extension MultiEventRequestParam {
    init(from eventRequestModel: MultiEventRequestModel, distanceToServerTime: TimeInterval) {
        self.init(
            originalID: eventRequestModel.id,
            appID: eventRequestModel.appID,
            schemaVersion: eventRequestModel.schemaVersion,
            appVersion: eventRequestModel.appVersion,
            visitor: eventRequestModel.visitor.toStruct(),
            session: eventRequestModel.session.toStruct(),
            networkConnectivityInfo: eventRequestModel.networkInfo.toStruct(),
            events: eventRequestModel.rawEvents.isEmpty ? eventRequestModel.events.map { $0.toStruct() } : eventRequestModel.rawEvents,
            timestamp: Date().timeIntervalSince1970 + distanceToServerTime,
            schemaName: eventRequestModel.events.first?.schemaName ?? ""
        )
    }
}
