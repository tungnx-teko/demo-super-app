//
//  ITicketPage.swift
//  TekServiceInterfaces
//
//  Created by Nguyen An Bien on 10/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol ITicketPage: IBasePage {
    var content: [ITicket] { get }
}
