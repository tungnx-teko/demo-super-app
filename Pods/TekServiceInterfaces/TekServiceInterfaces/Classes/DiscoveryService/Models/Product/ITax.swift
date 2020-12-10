//
//  ITax.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol ITax {
    var taxOut: Double? { get }
    var taxOutCode: String? { get }
}
