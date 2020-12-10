//
//  IPPMCondition.swift
//  Pods
//
//  Created by Nguyen Xuan on 10/5/20.
//

import Foundation

public protocol IPPMCondition: ICondition {
    var paymentMethods: [String] { get }
    var skus: [ISkuCondition] { get }
    var exclusions: [IExclusion] { get }
}
