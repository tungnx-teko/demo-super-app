//
//  IAttribute.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IAttribute {
    var code: String? { get }
    var name: String? { get }
    var values: [IAttributeValue] { get }
}
