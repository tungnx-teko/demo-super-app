//
//  ITicketPage.swift
//  TekServiceInterfaces
//
//  Created by Nguyen An Bien on 10/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol ITicket {
    var id: Int? { get }
    var ticketCode: String? { get }
    var code: String? { get }
    var orderCode: String? { get }
    var status: Int? { get }
    var statusName: String? { get }
    var receiveTime: String? { get }
    var receiveChannelId: Int? { get }
    var receiveChannelName: String? { get }
    var ticketPriorityTypeId: Int? { get }
    var ticketPriorityTypeName: String? { get }
    var ticketPriorityTypeColor: String? { get }
    var ticketTypeId: Int? { get }
    var ticketTypeName: String? { get }
    var title: String? { get }
    var note: String? { get }
    var text: String? { get }
    var iamUserId: String? { get }
    var terminal: String? { get }
    var platform: String? { get }
    var createdFullName: String? { get }
    var createdEmail: String? { get }
    var createdPhone: String? { get }
    var assignDepartmentName: String? { get }
    var phone: String? { get }
    var responseTime: String? { get }
    var lastNote: String? { get }
    var result: String? { get }
    var files: [IStorage] { get }
}
