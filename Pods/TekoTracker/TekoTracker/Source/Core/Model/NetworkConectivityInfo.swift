//
//  NetworkConnectivityInfo.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import CoreData

struct NetworkConnectivityInfo: Encodable {
    let phoneNumber: String
    let carrierName: String
    let networkType: String

    func toModel(context: NSManagedObjectContext) -> NetworkConnectivityInfoModel {
        .init(data: self, context: context)
    }

    static let unknown = NetworkConnectivityInfo(phoneNumber: "", carrierName: "", networkType: "")
}

@objc(NetworkConnectivityInfoModel)
final class NetworkConnectivityInfoModel: NSManagedObject {
    @NSManaged var phoneNumber: String
    @NSManaged var carrierName: String
    @NSManaged var networkType: String

    convenience init(data: NetworkConnectivityInfo, context: NSManagedObjectContext) {
        self.init(entity: .entity(forEntityName: String(describing: NetworkConnectivityInfoModel.self), in: context)!, insertInto: nil)
        self.phoneNumber = data.phoneNumber
        self.carrierName = data.carrierName
        self.networkType = data.networkType
    }

    func toStruct() -> NetworkConnectivityInfo {
        .init(
            phoneNumber: phoneNumber,
            carrierName: carrierName,
            networkType: networkType
        )
    }
}
