//
//  ITicketPageResult.swift
//  TekServiceInterfaces
//
//  Created by Nguyen Xuan on 10/14/20.
//

import Foundation

public protocol ITicketPageResult {
    var message: String? { get }
    var data: ITicketPage? { get }
}
