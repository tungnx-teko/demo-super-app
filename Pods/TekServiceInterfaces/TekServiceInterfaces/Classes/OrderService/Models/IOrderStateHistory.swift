//
//  IOrderStateHistory.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 10/8/20.
//

import Foundation

public protocol IOrderStateHistory {
    var state: Int? { get }
    var action: String? { get }
    var actor: IOrderItemCreator? { get }
    var updatedAt: String? { get }    
}
