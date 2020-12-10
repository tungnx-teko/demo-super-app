//
//  ConsumerOption.swift
//  BLUE
//
//  Created by tuananh on 3/11/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public struct ConsumerOption : Decodable {
    public let enableQrPayment : Bool?
    // public let _versions : [Version]?
    public let vnPayHotline : String?
    public let vinMartHotline : String?
    public let vnpayNotification : String?
    public let vnShopHotLine: String?
    
    enum CodingKeys: String, CodingKey {
        case enableQrPayment = "enableQrPayment"
        //		case _versions = "versions"
        case vnPayHotline = "vnPayHotline"
        case vinMartHotline = "vinMartHotline"
        case vnpayNotification = "vnpay-notif"
        case vnShopHotLine = "vnShopHotLine"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        enableQrPayment = try values.decodeIfPresent(Bool.self, forKey: .enableQrPayment)
        //		_versions = try values.decodeIfPresent([Version].self, forKey: ._versions)
        vnPayHotline = try values.decodeIfPresent(String.self, forKey: .vnPayHotline)
        vinMartHotline = try values.decodeIfPresent(String.self, forKey: .vinMartHotline)
        vnpayNotification = try values.decodeIfPresent(String.self, forKey: .vnpayNotification)
        vnShopHotLine = try values.decodeIfPresent(String.self, forKey: .vnShopHotLine)
    }
    
    init(_ snapshotValue: [String: AnyObject]){
        enableQrPayment = snapshotValue["enableQrPayment"] as? Bool
        vnPayHotline = snapshotValue["vnPayHotline"] as? String
        vinMartHotline = snapshotValue["vinMartHotline"] as? String
        vnpayNotification = snapshotValue["vnpay-notif"] as? String
        vnShopHotLine = snapshotValue["vnShopHotLine"] as? String
    }
    
}
