//
//  Visitor.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import CoreData

struct Visitor: Encodable {
    let clientID: String
    let userID: String

    enum CodingKeys: String, CodingKey {
        case clientID = "clientId"
        case userID = "userId"
    }

    func toModel(context: NSManagedObjectContext) -> VisitorModel {
        .init(data: self, context: context)
    }

    static let unknown = Visitor(clientID: "", userID: "")
}

@objc(VisitorModel)
final class VisitorModel: NSManagedObject {
    @NSManaged var clientID: String
    @NSManaged var userID: String

    convenience init(data: Visitor, context: NSManagedObjectContext) {
        self.init(entity: .entity(forEntityName: String(describing: VisitorModel.self), in: context)!, insertInto: nil)
        self.clientID = data.clientID
        self.userID = data.userID
    }

    func toStruct() -> Visitor {
        .init(
            clientID: clientID,
            userID: userID
        )
    }
}
