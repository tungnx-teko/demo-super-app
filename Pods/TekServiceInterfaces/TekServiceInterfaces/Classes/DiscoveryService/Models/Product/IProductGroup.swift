//
//  IProductGroup.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IProductGroup {
    var id: Int? { get }
    var name: String? { get }
    var visible: String? { get }
    var configs: [IGroupConfig] { get }
    var variants: [IVariant] { get }
}
