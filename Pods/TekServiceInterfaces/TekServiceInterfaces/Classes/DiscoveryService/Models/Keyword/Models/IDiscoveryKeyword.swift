//
//  IDiscoveryKeyword.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by tuananh on 11/3/20.
//

import Foundation

public protocol IDiscoveryKeyword {
    var query: String { get }
    var highlight: String? { get }
    var categoryCode: String? { get }
    var categoryName: String? { get }
}
