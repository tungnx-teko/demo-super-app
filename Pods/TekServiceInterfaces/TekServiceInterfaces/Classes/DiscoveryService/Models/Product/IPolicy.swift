//
//  IPolicy.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IPolicy {
    var icon: String? { get }
    var text: String? { get }
    var type: String? { get }
}
