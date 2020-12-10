//
//  EventRequestModel.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/7/20.
//

import CoreData

@objc protocol BaseRequestModel where Self: NSManagedObject {
    @objc var id: String { get }
    @objc var appID: String { get }
    @objc var schemaVersion: String { get }
    @objc var appVersion: String { get }
    @objc var session: SessionModel { get }
    @objc var visitor: VisitorModel { get }
    @objc var networkInfo: NetworkConnectivityInfoModel { get }
    @objc var eventCreatedAt: TimeInterval { get }
    @objc var uploadStatus: Int16 { set get }
    var events: Set<EventModel> { get }
}

extension BaseRequestModel {
    static var idKeyPathString: String { #keyPath(id) }
    static var eventCreatedAtKeyPathString: String { #keyPath(eventCreatedAt) }
    static var uploadStatusKeyPathString: String { #keyPath(uploadStatus) }
}
