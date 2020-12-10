//
//  LoyaltyMembershipCreateParam.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Thanh Bui Minh on 11/10/20.
//

import Foundation

public protocol LoyaltyMembershipCreateParamBuildable {
    func append(name: String) -> LoyaltyMembershipCreateParamBuilder
    func append(dob: Date?) -> LoyaltyMembershipCreateParamBuilder
    func append(sex: String?) -> LoyaltyMembershipCreateParamBuilder
    func append(address: String) -> LoyaltyMembershipCreateParamBuilder
    func append(wardCode: String?) -> LoyaltyMembershipCreateParamBuilder
    func append(wardName: String?) -> LoyaltyMembershipCreateParamBuilder
    func append(districtCode: String?) -> LoyaltyMembershipCreateParamBuilder
    func append(districtName: String?) -> LoyaltyMembershipCreateParamBuilder
    func append(provinceCode: String?) -> LoyaltyMembershipCreateParamBuilder
    func append(provinceName: String?) -> LoyaltyMembershipCreateParamBuilder
    
    func build() -> LoyaltyMembershipCreateParam
}

public struct LoyaltyMembershipCreateParam {
    public var name: String = ""
    public var dob: Date?
    public var sex: String?
    public var address: String = ""
    public var wardCode: String?
    public var wardName: String?
    public var districtCode: String?
    public var districtName: String?
    public var provinceCode: String?
    public var provinceName: String?
    
    public init() {}
    
    public init(name: String,
                dob: Date?,
                sex: String?,
                address: String,
                wardCode: String?,
                wardName: String?,
                districtCode: String?,
                districtName: String?,
                provinceCode: String?,
                provinceName: String?
    ) {
        self.name = name
        self.dob = dob
        self.sex = sex
        self.address = address
        self.wardCode = wardCode
        self.wardName = wardName
        self.districtCode = districtCode
        self.districtName = districtName
        self.provinceCode = provinceCode
        self.provinceName = provinceName
    }
    
    public var payloadDict: [String : Any] {
        var dict: [String: Any] = [:]
        
        dict["name"] = name
        dict["address"] = address
        
        if let dob = dob {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dict["dob"] = dateFormatter.string(from: dob)
        }
        if let sex = sex {
            dict["sex"] = sex
        }
        if let wardCode = wardCode {
            dict["wardCode"] = wardCode
        }
        if let wardName = wardName {
            dict["wardName"] = wardName
        }
        if let districtCode = districtCode {
            dict["districtCode"] = districtCode
        }
        if let districtName = districtName {
            dict["districtName"] = districtName
        }
        if let provinceCode = provinceCode {
            dict["provinceCode"] = provinceCode
        }
        if let provinceName = provinceName {
            dict["provinceName"] = provinceName
        }
        
        return dict
    }
    
}

public class LoyaltyMembershipCreateParamBuilder: LoyaltyMembershipCreateParamBuildable {
    public var name: String = ""
    public var dob: Date?
    public var sex: String?
    public var address: String = ""
    public var wardCode: String?
    public var wardName: String?
    public var districtCode: String?
    public var districtName: String?
    public var provinceCode: String?
    public var provinceName: String?
    
    public init() {}
    
    public func append(name: String) -> LoyaltyMembershipCreateParamBuilder {
        self.name = name
        return self
    }
    
    public func append(dob: Date?) -> LoyaltyMembershipCreateParamBuilder {
        self.dob = dob
        return self
    }
    
    public func append(sex: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.sex = sex
        return self
    }
    
    public func append(address: String) -> LoyaltyMembershipCreateParamBuilder {
        self.address = address
        return self
    }
    
    public func append(wardCode: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.wardCode = wardCode
        return self
    }
    
    public func append(wardName: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.wardName = wardName
        return self
    }
    
    public func append(districtCode: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.districtCode = districtCode
        return self
    }
    
    public func append(districtName: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.districtName = districtName
        return self
    }
    
    public func append(provinceCode: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.provinceCode = provinceCode
        return self
    }
    
    public func append(provinceName: String?) -> LoyaltyMembershipCreateParamBuilder {
        self.provinceName = provinceName
        return self
    }
    
    public func build() -> LoyaltyMembershipCreateParam {
        return LoyaltyMembershipCreateParam(name: self.name, dob: self.dob, sex: self.sex, address: self.address, wardCode: self.wardCode, wardName: self.wardName, districtCode: self.districtCode, districtName: self.districtName, provinceCode: self.provinceCode, provinceName: self.provinceName)
    }

}
