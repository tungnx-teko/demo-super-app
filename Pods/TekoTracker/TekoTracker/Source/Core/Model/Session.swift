//
//  Session.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import CoreData

struct Session: Encodable {
    let id: String
    var lastActiveAt: TimeInterval
    var createdAt: TimeInterval
    let offset: String
    let timezone: String
    let osVersion: String
    let branchName: String
    let modelName: String
    let resolution: String

    enum CodingKeys: String, CodingKey {
        case id, lastActiveAt, createdAt, offset
        case timezone = "tz"
        case platform, modelName, branchName, manufacturerName
        case resolution = "res"
        case osVersion = "osVer"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(Int64(lastActiveAt * 1000), forKey: .lastActiveAt)
        try container.encode(Int64(createdAt * 1000), forKey: .createdAt)
        try container.encode(offset, forKey: .offset)
        try container.encode(timezone, forKey: .timezone)
        try container.encode("iOS", forKey: .platform)
        try container.encode(osVersion, forKey: .osVersion)
        try container.encode(branchName, forKey: .branchName)
        try container.encode("Apple Inc.", forKey: .manufacturerName)
        try container.encode(modelName, forKey: .modelName)
        try container.encode(resolution, forKey: .resolution)
    }

    func toModel(context: NSManagedObjectContext) -> SessionModel {
        .init(data: self, context: context)
    }

    static let unknown = Session(id: "", lastActiveAt: 0, createdAt: 0, offset: "", timezone: "", osVersion: "", branchName: "", modelName: "", resolution: "")
}

@objc(SessionModel)
final class SessionModel: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var lastActiveAt: TimeInterval
    @NSManaged var createdAt: TimeInterval
    @NSManaged var offset: String
    @NSManaged var timezone: String
    @NSManaged var osVersion: String
    @NSManaged var branchName: String
    @NSManaged var modelName: String
    @NSManaged var resolution: String

    convenience init(data: Session, context: NSManagedObjectContext) {
        self.init(entity: .entity(forEntityName: String(describing: SessionModel.self), in: context)!, insertInto: nil)
        self.id = data.id
        self.lastActiveAt = data.lastActiveAt
        self.createdAt = data.createdAt
        self.offset = data.offset
        self.timezone = data.timezone
        self.osVersion = data.osVersion
        self.branchName = data.branchName
        self.modelName = data.modelName
        self.resolution = data.resolution
    }

    func toStruct() -> Session {
        .init(
            id: id,
            lastActiveAt: lastActiveAt,
            createdAt: createdAt,
            offset: offset,
            timezone: timezone,
            osVersion: osVersion,
            branchName: branchName,
            modelName: modelName,
            resolution: resolution
        )
    }
}
