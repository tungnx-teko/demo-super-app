//
//  IOrderService.swift
//  TekServiceInterfaces
//
//  Created by Tung Nguyen on 8/6/20.
//

import Foundation

public typealias OrderHandler = (_ order: IOrder?, _ isSuccess: Bool) -> Void
public typealias OrderListHandler = (_ list: IOrderListResult?, _ isSuccess: Bool) -> Void
public typealias CancelOrderHandler = (_ response: IOrderResponse?, _ isSuccess: Bool) -> Void
public typealias MarketOrderCreateHandler = (_ result: IMarketOrderCreateResult?, _ error: IMarketOrderError?) -> Void
public typealias MarketOrderGetHandler = (_ result: IOrderListItem?, _ error: IMarketOrderError?) -> Void
public typealias MarketOrderConfirmPaymentHandler = (_ result: IMarketOrderCreateResult?, _ error: IMarketOrderError?) -> Void

public protocol IOrderService {
    func getOrder(id: String, completion: @escaping OrderHandler)
    func queryOrder(id: String, completion: @escaping OrderHandler)
    func getOrderList(creatorId: String, orderCodes: [String], offset: Int, limit: Int, completion: @escaping OrderListHandler)
    func getMarketOrderList(creatorId: String, orderCodes: [String], offset: Int, limit: Int, completion: @escaping OrderListHandler)
    func cancelChildOrder(id: String, completion: @escaping CancelOrderHandler)
    func cancelMarketOrder(id: String, completion: @escaping CancelOrderHandler)
    func createMarketOrder(payload: OrderCreatePayload, completion: @escaping MarketOrderCreateHandler)
    func getMarketOrder(id: String, completion: @escaping MarketOrderGetHandler)
    func confirmPayment(id: String, payload: MarketOrderConfirmPaymentPayload, completion: @escaping MarketOrderConfirmPaymentHandler)
}
