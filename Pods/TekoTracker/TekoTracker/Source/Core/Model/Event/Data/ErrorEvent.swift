//
//  ErrorEvent.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 5/5/20.
//

import Foundation

public enum ErrorSource: String {
    case client
    case http
    case webSocket
}

final public class ErrorEventData: NSObject, EventDataProtocol, Encodable {
    public var errorSource: ErrorSource! {
        get { ErrorSource(rawValue: rawErrorSource) }
        set { rawErrorSource = newValue.rawValue }
    }
    private var rawErrorSource: String

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc(errorSource)
    public var objcErrorSource: String {
        set {
            if ErrorSource(rawValue: newValue) == nil {
                preconditionFailure("Unsupported error source")
            }
            self.rawErrorSource = newValue
        }
        get { rawErrorSource }
    }

    @objc public var apiCall: String
    @objc public var apiPayload: String?
    @objc public var httpResponseCode: Int
    @objc public var responseJson: String?
    @objc public var errorCode: String
    @objc public var errorMessage: String
    @objc public var extra: FlattenExtraAttribute?

    public init(errorSource: ErrorSource, apiCall: String, apiPayload: String?, httpResponseCode: Int, responseJson: String? = nil, errorCode: String, errorMessage: String, extra: FlattenExtraAttribute? = nil) {
        self.rawErrorSource = errorSource.rawValue
        self.apiCall = apiCall
        self.apiPayload = apiPayload.removeBreakLine()
        self.httpResponseCode = httpResponseCode
        self.responseJson = responseJson.removeBreakLine()
        self.errorCode = errorCode
        self.errorMessage = errorMessage.removeBreakLine()
        self.extra = extra
        super.init()
    }

    @available(*, message: "Unavailable in Swift", unavailable)
    @objc public init(errorSource: String, apiCall: String, apiPayload: String?, httpResponseCode: Int, responseJson: String? = nil, errorCode: String, errorMessage: String, extra: FlattenExtraAttribute?) {
        if ErrorSource(rawValue: errorSource) == nil {
            preconditionFailure("Unsupported error source")
        }
        self.rawErrorSource = errorSource
        self.apiCall = apiCall
        self.apiPayload = apiPayload.removeBreakLine()
        self.httpResponseCode = httpResponseCode
        self.responseJson = responseJson.removeBreakLine()
        self.errorCode = errorCode
        self.errorMessage = errorMessage.removeBreakLine()
        self.extra = extra
        super.init()
    }

    enum CodingKeys: String, CodingKey {
        case errorSource, apiCall, apiPayload, httpResponseCode, responseJson, errorCode, errorMessage
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rawErrorSource, forKey: .errorSource)
        try container.encode(apiCall, forKey: .apiCall)
        if let apiPayload = apiPayload, !apiPayload.isEmpty {
            try container.encode(apiPayload, forKey: .apiPayload)
        } else {
            try container.encode("undefined", forKey: .apiPayload)
        }
        try container.encode("\(httpResponseCode)", forKey: .httpResponseCode)
        try container.encodeIfPresent(responseJson, forKey: .responseJson)
        if errorCode.isEmpty {
            try container.encode("undefined", forKey: .errorCode)
        } else {
            try container.encode(errorCode, forKey: .errorCode)
        }
        if errorMessage.isEmpty {
            try container.encode("undefined", forKey: .errorMessage)
        } else {
            try container.encode(errorMessage, forKey: .errorMessage)
        }
        try extra?.encode(to: encoder)
    }

    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
