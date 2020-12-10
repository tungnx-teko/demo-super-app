//
//  EventModel.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 2/20/20.
//

import CoreData

@objc(EventModel)
final class EventModel: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var eventName: String
    @NSManaged var eventType: String
    @NSManaged var createdAt: TimeInterval
    @NSManaged var schemaName: String
    @NSManaged var viewID: String
    @NSManaged var data: Data

    convenience init(event: Event, context: NSManagedObjectContext) {
        self.init(entity: .entity(forEntityName: String(describing: EventModel.self), in: context)!, insertInto: nil)
        self.id = event.id
        self.createdAt = event.createdAt
        self.eventName = event.eventName
        self.eventType = event.eventType
        self.schemaName = event.schemaName
        self.viewID = event.viewID
        self.data = event.data
    }

    func toStruct() -> Event {
        Event(
            id: id,
            createdAt: createdAt,
            eventType: eventType,
            schemaName: schemaName,
            eventName: eventName,
            viewID: viewID,
            data: data
        )
    }
}
