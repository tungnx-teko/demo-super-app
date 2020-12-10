//
//  IIdentityService.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/21/20.
//

import Foundation

public typealias IdentityResponseHandler = (_ phoneNumber: String?, _ isSuccess: Bool, _ errorCode: Int?) -> Void

public protocol IIdentityService {
    func verifyPhone(_ phoneNumber: String, completion: @escaping IdentityResponseHandler)
    func updatePhone(_ phoneNumber: String, otp: String, completion: @escaping IdentityResponseHandler)
}
