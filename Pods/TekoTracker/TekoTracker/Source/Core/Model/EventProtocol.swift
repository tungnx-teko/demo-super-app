//
//  EventProtocol.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 2/20/20.
//

import CoreData

public protocol StringIdentifier {
    var value: String { get }
}

extension String: StringIdentifier {
    public var value: String { self }
}
