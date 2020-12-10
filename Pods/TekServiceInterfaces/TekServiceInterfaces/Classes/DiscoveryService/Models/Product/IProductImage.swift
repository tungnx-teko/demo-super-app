//
//  IProductImage.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/28/20.
//

import Foundation

public protocol IProductImage {
    var url: String? { get }
    var priority: Int? { get }
    var label: String? { get }
}
