//
//  IVariantAttribute.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IVariantAttribute {
    var id: Int? { get }
    var code: String? { get }
    var value: String? { get }
    var optionId: Int? { get }
}
