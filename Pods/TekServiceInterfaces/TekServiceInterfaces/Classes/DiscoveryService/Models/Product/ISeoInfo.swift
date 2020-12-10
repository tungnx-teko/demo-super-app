//
//  ISeoInfo.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol ISeoInfo {
    var description: String? { get }
    var shortDescription: String? { get }
    var metaTitle: String? { get }
    var metaKeyword: String? { get }
    var metaDescription: String? { get }
}
