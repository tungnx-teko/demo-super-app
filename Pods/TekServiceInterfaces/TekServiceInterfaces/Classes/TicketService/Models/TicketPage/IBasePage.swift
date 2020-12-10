//
//  IBasePage.swift
//  TekServiceInterfaces
//
//  Created by Nguyen An Bien on 10/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IBasePage {
    var number: Int? { get }
    var size: Int? { get }
    var totalPages: Int? { get }
    var numberOfElements: Int? { get }
    var totalElements: Int? { get }
    var first: Bool { get }
    var last: Bool { get }
}
