//
//  ITicketResult.swift
//  TekServiceInterfaces
//
//  Created by Nguyen Xuan on 10/14/20.
//

import Foundation

public protocol ITicketResult {
    var message: String? { get }
    var data: ITicket? { get }
}
