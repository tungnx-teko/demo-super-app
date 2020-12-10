//
//  IUserInfo.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Tung Nguyen on 8/11/20.
//

import Foundation

public protocol IUserInfo {
    var userId: String? { get }
    var name: String? { get }
    var picture: String? { get }
    var dob: String? { get }
    var email: String? { get }
    var telephone: String? { get }
    var sex: String? { get }
    var memberships: IMemberShip? { get }
    var contactAddress: IContactAddress? { get }
}

public protocol IMemberShip {
    var providerUserAddress: String? { get }
    var clientCode: String? { get }
    var userId: String? { get }
    var providerMemberId: String? { get }
    var providerName: String? { get }
    var providerNationalId: String? { get }
}

public protocol IContactAddress {
    var address: String? { get }
    var wardCode: String? { get }
    var wardName: String? { get }
    var districtCode: String? { get }
    var districtName: String? { get }
    var provinceCode: String? { get }
    var provinceName: String? { get }
}
