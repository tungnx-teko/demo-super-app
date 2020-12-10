//
//  IOrderItemCreator.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 10/8/20.
//

import Foundation

public protocol IOrderItemCreator {
    var id: String? { get }
    var name: String? { get }
    var email: String? { get }
    var phone: String? { get }
    var asiaUserName: String? { get }
}
