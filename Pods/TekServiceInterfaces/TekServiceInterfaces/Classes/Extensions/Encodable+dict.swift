//
//  Codable+.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/18/20.
//

import Foundation

public extension Encodable {
    
    func asDictionary() throws -> [String : Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    func toDict() -> [String : Any] {
        var dict: [String : Any] = [:]
        do {
            dict = try self.asDictionary()
        } catch {
            print(error)
        }
        return dict
    }
    
    var dictValue: [String : Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String : Any] }
    }
}
