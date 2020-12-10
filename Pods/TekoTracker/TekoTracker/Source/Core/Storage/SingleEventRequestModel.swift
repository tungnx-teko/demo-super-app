//
//  EventRequest.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/23/19.
//

import CoreData

@objc(SingleEventRequestModel)
final class SingleEventRequestModel: NSManagedObject, BaseRequestModel {
    @NSManaged var id: String
    @NSManaged var appID: String
    @NSManaged var schemaVersion: String
    @NSManaged var appVersion: String
    @NSManaged var session: SessionModel
    @NSManaged var visitor: VisitorModel
    @NSManaged var networkInfo: NetworkConnectivityInfoModel
    @NSManaged var eventCreatedAt: TimeInterval
    @NSManaged var uploadStatus: Int16
    @NSManaged var event: EventModel

    var rawEvent: Event? = nil

    convenience init(event: Event, appID: String, schemaVersion: String, appVersion: String, session: Session, visitor: Visitor, networkInfo: NetworkConnectivityInfo, context: NSManagedObjectContext) {
        self.init(entity: .entity(forEntityName: String(describing: SingleEventRequestModel.self), in: context)!, insertInto: nil)
        self.uploadStatus = Constant.UploadStatus.ready.rawValue
        self.appID = appID
        self.schemaVersion = schemaVersion
        self.appVersion = appVersion
        self.session = session.toModel(context: context)
        self.visitor = visitor.toModel(context: context)
        self.networkInfo = networkInfo.toModel(context: context)
        self.rawEvent = event

        let eventModel = event.toModel(context: context)
        self.event = eventModel
        self.id = "S_\(eventModel.id)"
        self.eventCreatedAt = eventModel.createdAt
    }

    var events: Set<EventModel> { Set(arrayLiteral: event) }
}

extension Array where Element: SingleEventRequestModel {
    func toSingleEventRequests(distanceToServerTime: TimeInterval) -> [SingleEventRequestParam] {
        map { SingleEventRequestParam(from: $0, distanceToServerTime: distanceToServerTime) }
    }
}
