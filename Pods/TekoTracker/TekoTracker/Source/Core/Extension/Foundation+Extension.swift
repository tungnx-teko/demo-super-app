//
//  Foundation+Extension.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

public func += <K, V> ( left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

public func + <K, V>(lhs: [K:V], rhs: [K:V]) -> [K:V] {
    var res: [K:V] = lhs
    res += rhs
    return res
}

extension Encodable {
    public func asData() throws -> Data {
        try JSONEncoder().encode(self)
    }

    public func stringify(encoder: JSONEncoder = .init(), encoding: String.Encoding = .utf8) -> String? {
        try? String(data: encoder.encode(self), encoding: encoding)
    }
}
