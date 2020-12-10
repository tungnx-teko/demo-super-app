//
//  IOptionImage.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IOptionImage {
    var url: String? { get }
    var priority: Int? { get }
    var path: String? { get }
}
