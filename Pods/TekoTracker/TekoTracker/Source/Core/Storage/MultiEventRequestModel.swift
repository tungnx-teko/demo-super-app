//
//  MultiEventRequest.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/7/20.
//

import CoreData

@objc(MultiEventRequestModel)
final class MultiEventRequestModel: NSManagedObject, BaseRequestModel {
    @NSManaged var id: String
    @NSManaged var appID: String
    @NSManaged var schemaVersion: String
    @NSManaged var appVersion: String
    @NSManaged var session: SessionModel
    @NSManaged var visitor: VisitorModel
    @NSManaged var networkInfo: NetworkConnectivityInfoModel
    @NSManaged var eventCreatedAt: TimeInterval
    @NSManaged var uploadStatus: Int16
    @NSManaged var events: Set<EventModel>

    var rawEvents: [Event] = []

    convenience init(events: [Event], appID: String, schemaVersion: String, appVersion: String, session: Session, visitor: Visitor, networkInfo: NetworkConnectivityInfo, context: NSManagedObjectContext) {
        self.init(entity: .entity(forEntityName: String(describing: MultiEventRequestModel.self), in: context)!, insertInto: nil)
        self.uploadStatus = Constant.UploadStatus.ready.rawValue
        self.appID = appID
        self.schemaVersion = schemaVersion
        self.appVersion = appVersion
        self.session = session.toModel(context: context)
        self.visitor = visitor.toModel(context: context)
        self.networkInfo = networkInfo.toModel(context: context)
        self.rawEvents = events

        self.id = "M_\(UUID().uuidString.lowercased())"
        self.events = Set(events.map { $0.toModel(context: context) })
    }
}

extension Array where Element: MultiEventRequestModel {
    func toSingleEventRequests(distanceToServerTime: TimeInterval) -> [MultiEventRequestParam] {
        map { MultiEventRequestParam(from: $0, distanceToServerTime: distanceToServerTime) }
    }
}
