//
//  EventRequestModelMigrationPolicy.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 1/31/20.
//

import CoreData
import Foundation

@objc
final class EventRequestModelMigrationPolicy: NSEntityMigrationPolicy {
    @objc func setDefaultSchemaVersion() -> String { "1.0.0" }

    @objc(computeViewIDFromEventData:)
    func computeViewID(from eventData: Data) -> String {
        do {
            let json = try JSONSerialization.jsonObject(with: eventData, options: .allowFragments) as? [String: Any]
            return json?[Event.CodingKeys.viewID.stringValue] as? String ?? ""
        } catch {
            return ""
        }
    }
}
