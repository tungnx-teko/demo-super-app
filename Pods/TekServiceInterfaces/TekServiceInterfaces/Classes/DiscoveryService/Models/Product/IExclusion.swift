//
//  IExclusion.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/29/20.
//

import Foundation

public protocol IExclusion {
    var applyOn: [String] { get }
    var isDefault : [Bool] { get }
}
