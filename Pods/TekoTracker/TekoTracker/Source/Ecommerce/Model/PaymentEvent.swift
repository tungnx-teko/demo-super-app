//
//  PaymentEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/6/20.
//

import Foundation

public enum PaymentMethod: String {
    case cash = "Cash"
    case jcb = "JCB"
    case visa = "Visa"
    case masterCard = "MasterCard"
    case internetBanking = "InternetBanking"
    case eWallet = "EWallet"
    case vnpayQR = "VnpayQR"
    case paymentGW = "PaymentGW"
}

final public class PaymentEventData: NSObject, EventDataProtocol, Encodable {
    @objc public var orderID: String
    @objc public var referral: String?
    @objc public var amount: Double

    public var paymentMethod: PaymentMethod {
        set { rawPaymentMethod = newValue.rawValue }
        get { PaymentMethod(rawValue: rawPaymentMethod)! }
    }
    private var rawPaymentMethod: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(paymentMethod)
    public var objcPaymentMethod: String {
        set {
            if PaymentMethod(rawValue: newValue) == nil {
                preconditionFailure("Unsupported payment method")
            }
            rawPaymentMethod = newValue
        }
        get { rawPaymentMethod }
    }
    @objc public var paymentBank: String?

    public var status: EcommerceEventStatus {
        set { rawStatus = newValue.rawValue }
        get { EcommerceEventStatus(rawValue: rawStatus)! }
    }
    private var rawStatus: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(status)
    public var objcStatus: String {
        set {
            if EcommerceEventStatus(rawValue: newValue) == nil {
                preconditionFailure("Unsupported status")
            }
            rawStatus = newValue
        }
        get { rawStatus }
    }
    public var statusCode: Int?
    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(statusCode)
    public var objcStatusCode: NSNumber? {
        set { statusCode = newValue?.intValue }
        get { statusCode as NSNumber? }
    }

    public init(orderID: String, referral: String?, amount: Double, paymentMethod: PaymentMethod, paymentBank: String? = nil, status: EcommerceEventStatus, statusCode: Int? = nil) {
        self.orderID = orderID
        self.referral = referral
        self.amount = amount
        self.rawPaymentMethod = paymentMethod.rawValue
        self.paymentBank = paymentBank
        self.rawStatus = status.rawValue
        self.statusCode = statusCode
        super.init()
    }

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc public init(orderID: String, referral: String?, amount: Double, paymentMethod: String, paymentBank: String?, status: String, statusCode: NSNumber?) {
        if PaymentMethod(rawValue: paymentMethod) == nil {
            preconditionFailure("Unsupported payment method")
        }
        if EcommerceEventStatus(rawValue: status) == nil {
            preconditionFailure("Unsupported status")
        }
        self.orderID = orderID
        self.referral = referral
        self.amount = amount
        self.rawPaymentMethod = paymentMethod
        self.paymentBank = paymentBank
        self.rawStatus = status
        self.statusCode = statusCode?.intValue
        super.init()
    }

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case referral, amount, paymentMethod, paymentBank, status, statusCode
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderID, forKey: .orderID)
        try container.encodeIfPresent(referral, forKey: .referral)
        try container.encode(amount, forKey: .amount)
        try container.encode(rawPaymentMethod, forKey: .paymentMethod)
        try container.encodeIfPresent(paymentBank, forKey: .paymentBank)
        try container.encode(rawStatus, forKey: .status)
        try container.encodeIfPresent(statusCode, forKey: .statusCode)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
