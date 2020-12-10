//
//  IPolicyService.swift
//  Pods
//
//  Created by Nguyen Xuan on 10/12/20.
//

import Foundation
public typealias GetPoliciesHandler = (_ policies: [IPolicyDetail], _ isSuccess: Bool, _ error: Error?) -> Void

public protocol IPolicyService {
    func getPolicy(sku: String, completion: @escaping GetPoliciesHandler)
}
