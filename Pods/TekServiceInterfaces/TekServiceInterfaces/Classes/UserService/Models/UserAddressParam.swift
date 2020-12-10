//
//  UserAddressParam.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/18/20.
//

import Foundation

public struct UserAddressParam: Encodable {
    public var address: String = ""
    public var addressNote: String?
    public var isDefault: Bool = false
    public var email: String?
    public var name: String = ""
    public var telephone: String = ""
    public var longitude: String?
    public var latitude: String?
    public var clientCode: String?
    public var provinceCode: String?
    public var districtCode: String?
    public var wardCode: String?
    public var provinceName: String?
    public var districtName: String?
    public var wardName: String?
    public var userId: String?
    public var id: String?
    
    enum CodingKeys: String, CodingKey {
        case address, addressNote, isDefault, email, name, telephone, longitude, latitude, clientCode, provinceCode, districtCode, wardCode, provinceName, districtName, wardName, userId, id
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(addressNote, forKey: .addressNote)
        try container.encodeIfPresent(isDefault, forKey: .isDefault)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(telephone, forKey: .telephone)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(clientCode, forKey: .clientCode)
        try container.encodeIfPresent(provinceCode, forKey: .provinceCode)
        try container.encodeIfPresent(districtCode, forKey: .districtCode)
        try container.encodeIfPresent(wardCode, forKey: .wardCode)
        try container.encodeIfPresent(provinceName, forKey: .provinceName)
        try container.encodeIfPresent(districtName, forKey: .districtName)
        try container.encodeIfPresent(wardName, forKey: .wardName)
        try container.encodeIfPresent(userId, forKey: .userId)
        try container.encodeIfPresent(id, forKey: .id)
    }
    
    public init() {}
    
    public init(address: String = "",
                addressNote: String?,
                isDefault: Bool = false,
                email: String?,
                name: String = "",
                telephone: String = "",
                longitude: String?,
                latitude: String?,
                clientCode: String?,
                provinceCode: String?,
                districtCode: String?,
                wardCode: String?,
                provinceName: String?,
                districtName: String?,
                wardName: String?,
                userId: String?,
                id: String?) {
        self.address = address
        self.addressNote = addressNote
        self.isDefault = isDefault
        self.email = email
        self.name = name
        self.telephone = telephone
        self.longitude = longitude
        self.latitude = latitude
        self.clientCode = clientCode
        self.provinceCode = provinceCode
        self.districtCode = districtCode
        self.wardCode = wardCode
        self.provinceName = provinceName
        self.districtName = districtName
        self.wardName = wardName
        self.userId = userId
        self.id = id
    }
    
    public var payloadDict: [String : Any] {
        return self.toDict()
    }
}
