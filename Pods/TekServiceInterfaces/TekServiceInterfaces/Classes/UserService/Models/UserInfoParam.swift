//
//  UserInfoParam.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/18/20.
//

import Foundation

public protocol UserInfoParamBuildable {
    func append(dob: Date?) -> UserInfoParamBuilder
    func append(sex: String?) -> UserInfoParamBuilder
    func append(phone: String?) -> UserInfoParamBuilder
    func append(email: String?) -> UserInfoParamBuilder
    func append(name: String?) -> UserInfoParamBuilder
    
    func build() -> UserInfoParam
}

public struct UserInfoParam {
    public var dob: Date?
    public var sex: String?
    public var phone: String?
    public var email: String?
    public var name: String?
    
    public init() {}
    
    public init(dob: Date?,
                sex: String?,
                phone: String?,
                email: String?,
                name: String?) {
        self.dob = dob
        self.sex = sex
        self.phone = phone
        self.email = email
        self.name = name
    }
    
    public var payloadDict: [String : Any] {
        var dict: [String: Any] = [:]
        if let dob = dob {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dict["dob"] = dateFormatter.string(from: dob)
        }
        if let sex = sex {
            dict["sex"] = sex
        }
        if let phone = phone {
            dict["telephone"] = phone
        }
        if let email = email {
            dict["email"] = email
        }
        if let name = name {
            dict["name"] = name
        }
        return dict
    }
    
}

public class UserInfoParamBuilder: UserInfoParamBuildable {
    
    var dob: Date?
    var sex: String?
    var phone: String?
    var email: String?
    var name: String?
    
    public init() {}

    public func append(dob: Date?) -> UserInfoParamBuilder {
        self.dob = dob
        return self
    }
    
    public func append(sex: String?) -> UserInfoParamBuilder {
        self.sex = sex
        return self
    }
    
    public func append(phone: String?) -> UserInfoParamBuilder {
        self.phone = phone
        return self
    }
    
    public func append(email: String?) -> UserInfoParamBuilder {
        self.email = email
        return self
    }
    
    public func append(name: String?) -> UserInfoParamBuilder {
        self.name = name
        return self
    }
    
    public func build() -> UserInfoParam {
        return UserInfoParam(dob: dob, sex: sex, phone: phone, email: email, name: name)
    }
    
}
