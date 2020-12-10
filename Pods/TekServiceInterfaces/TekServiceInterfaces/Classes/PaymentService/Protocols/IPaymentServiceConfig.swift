//
//  IPaymentConfig.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/19/20.
//

import Foundation

public protocol IPaymentServiceConfig {
    var clientCode: String { get }
    var terminalCode: String { get }
    var serviceCode: String { get }
    var secretKey: String { get }
    var baseUrl: String { get }
}
