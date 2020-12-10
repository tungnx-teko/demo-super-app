//
//  IAttributeGroup.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IAttributeGroup {
    var id : Int? { get }
    var name : String? { get }
    var value : String? { get }
    var priority : Int? { get }
    var parentId : Int? { get }
}
