//
//  TicketUpdatePayload.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by Le Vu Huy on 10/22/20.
//

import Foundation

public class TicketUpdatePayload: Encodable {
    public var text: String?
    public var filesId: [Int] = []

    public init(text: String? = nil,
         filesId: [Int] = []) {
        self.text = text
        self.filesId = filesId
    }
}
