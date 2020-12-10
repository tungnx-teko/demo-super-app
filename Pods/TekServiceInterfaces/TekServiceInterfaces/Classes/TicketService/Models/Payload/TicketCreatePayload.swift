//
//  CreateTicketPayload.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Le Vu Huy on 10/22/20.
//

import Foundation

public struct TicketCreatePayload: Encodable {
    public var ticketTypeId: Int = 100
    public var title: String?
    public var refTicketId: Int?
    public var priority: Int?
    public var receiveChannelId: Int?
    public var provinceId: Int?
    public var saleChannelId: Int?
    public var assignDepartmentId: Int?
    public var orderCode: String
    public var customerId: Int?
    public var customerPhone: String
    public var text: String
    public var terminalCode: String?
    public var filesId: [Int] = []
    
    public init(orderCode: String,
        customerPhone: String,
        text: String) {
        self.orderCode = orderCode
        self.customerPhone = customerPhone
        self.text = text
    }
    
    public init(ticketTypeId: Int,
         title: String? = nil,
         refTicketId: Int? = nil,
         priority: Int? = nil,
         receiveChannelId: Int? = nil,
         provinceId: Int? = nil,
         saleChannelId: Int? = nil,
         assignDepartmentId: Int? = nil,
         orderCode: String,
         customerId: Int? = nil,
         customerPhone: String,
         text: String,
         terminalCode: String? = nil,
         filesId: [Int]) {
        self.ticketTypeId = ticketTypeId
        self.title = title
        self.refTicketId = refTicketId
        self.priority = priority
        self.receiveChannelId = receiveChannelId
        self.provinceId = provinceId
        self.saleChannelId = saleChannelId
        self.assignDepartmentId = assignDepartmentId
        self.orderCode = orderCode
        self.customerId = customerId
        self.customerPhone = customerPhone
        self.text = text
        self.terminalCode = terminalCode
        self.filesId = filesId
    }
}

public class TicketCreatePayloadBuilder {
    var ticketTypeId: Int = 100
    var title: String?
    var refTicketId: Int?
    var priority: Int?
    var receiveChannelId: Int?
    var provinceId: Int?
    var saleChannelId: Int?
    var assignDepartmentId: Int?
    var orderCode: String
    var customerId: Int?
    var customerPhone: String
    var text: String
    var terminalCode: String?
    var filesId: [Int] = []
    
    public init(orderCode: String, customerPhone: String, text: String) {
        self.orderCode = orderCode
        self.customerPhone = customerPhone
        self.text = text
    }
    
    public func append(ticketTypeId: Int) -> TicketCreatePayloadBuilder {
        self.ticketTypeId = ticketTypeId
        return self
    }
    
    public func append(title: String) -> TicketCreatePayloadBuilder {
        self.title = title
        return self
    }
    
    public func append(refTicketId: Int) -> TicketCreatePayloadBuilder {
        self.refTicketId = refTicketId
        return self
    }
    
    public func append(priority: Int) -> TicketCreatePayloadBuilder {
        self.priority = priority
        return self
    }
    
    public func append(receiveChannelId: Int) -> TicketCreatePayloadBuilder {
        self.receiveChannelId = receiveChannelId
        return self
    }
    
    public func append(provinceId: Int) -> TicketCreatePayloadBuilder {
        self.provinceId = provinceId
        return self
    }
    
    public func append(saleChannelId: Int) -> TicketCreatePayloadBuilder {
        self.saleChannelId = saleChannelId
        return self
    }
    
    public func append(assignDepartmentId: Int) -> TicketCreatePayloadBuilder {
        self.assignDepartmentId = assignDepartmentId
        return self
    }
    
    public func append(customerId: Int) -> TicketCreatePayloadBuilder {
        self.customerId = customerId
        return self
    }
    
    public func append(terminalCode: String) -> TicketCreatePayloadBuilder {
        self.terminalCode = terminalCode
        return self
    }
    
    public func append(filesId: [Int]) -> TicketCreatePayloadBuilder {
        self.filesId = filesId
        return self
    }
    
    public func build() -> TicketCreatePayload {
        return TicketCreatePayload(ticketTypeId: ticketTypeId,
                                   title: title,
                                   refTicketId: refTicketId,
                                   priority: priority,
                                   receiveChannelId: receiveChannelId,
                                   provinceId: provinceId,
                                   saleChannelId: saleChannelId,
                                   assignDepartmentId: assignDepartmentId,
                                   orderCode: orderCode,
                                   customerId: customerId,
                                   customerPhone: customerPhone,
                                   text: text,
                                   terminalCode: terminalCode,
                                   filesId: filesId)
    }
}
