//
//  IAttributeValue.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IAttributeValue {
    var count: Int? { get }
    var value: String? { get }
    var optionId: String? { get }
}
