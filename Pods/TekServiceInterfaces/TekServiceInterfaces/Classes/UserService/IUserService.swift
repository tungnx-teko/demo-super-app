//
//  UserService.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/11/20.
//

import Foundation

public protocol IUserService {
    // User address
    func addAddress(address: UserAddressParam, completion: @escaping (IUserAddress?) -> ())
    func updateAddress(address: UserAddressParam, completion: @escaping (Bool) -> ())
    func getListAddress(completion: @escaping ([IUserAddress]) -> ())
    func deleteAddress(id: String, completion: @escaping (Bool) -> ())
    
    // User info
    func getUserInfo(completion: @escaping (IUserInfo?) -> ())
    func updateUserInfo(userInfo: UserInfoParam, completion: @escaping (IUserInfo?) -> ())
    
    // Loyalty
    func getLoyaltyBalance(completion: @escaping (ILoyaltyBalance?) -> ())
    func registerLoyaltyMembership(membership: LoyaltyMembershipCreateParam, completion: @escaping (IUserInfo?) -> ())
}
