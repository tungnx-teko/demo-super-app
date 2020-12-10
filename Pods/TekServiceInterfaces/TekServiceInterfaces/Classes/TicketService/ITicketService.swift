//
//  ITicketService.swift
//  TekServiceInterfaces
//
//  Created by Nguyen Xuan on 10/14/20.
//

import Foundation

public typealias TicketHandler = (_ result: ITicketResult?, _ isSuccess: Bool, _ error: Error?) -> ()
public typealias TicketPageHandler = (_ result: ITicketPageResult?, _ isSuccess: Bool, _ error: Error?) -> ()

public protocol ITicketService {

    func createTicket(payload: TicketCreatePayload,
                      completion: @escaping TicketHandler)

    func searchTicket(ticketCode: String?, orderCodes: [String], status: Int?,
                      createdFrom: Date?, createdTo: Date?,
                      page: Int?, size: Int?,
                      completion: @escaping TicketPageHandler)

    func updateTicket(ticketId: Int, payload: TicketUpdatePayload, completion: @escaping TicketHandler)

    func searchTicketById(_ ticketId: Int, completion: @escaping TicketHandler)

}
