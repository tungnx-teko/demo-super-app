//
//  Constant.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/18/19.
//

import Foundation

enum Constant {
    static let minTimeBetweenSession: TimeInterval = 1800 // 30m
    static let maxEventDatabaseCapacity = 20
    static let eventDeleteBatchSize = 20
    static let eventUploadBatchSize = 30
    static let eventUploadPeriodTimestamp = 20 // 20s
    static let retryWhenFailed: Int = 3
    static let maxRetryTimes: Int16 = 3
    static let configFileName = "TekoTracker-Info.plist"

    static let upperRangeScrollingVelocity: CGFloat = 1.2

    enum UploadStatus: Int16 {
        case failed = 0
        case processing = 1
        case completed = 2
        case never = 3
        case ready = 4
        case needToSyncTime = 5
    }

    enum Error {
        static let unsupportedEventTypeEventInitialization = NSError(domain: "EventInitialization", code: -1, userInfo: [
            NSLocalizedDescriptionKey: "Unsupported event data type"
        ])

        static let invalidViewIDEventInitialization = NSError(domain: "EventInitialization", code: -1, userInfo: [
            NSLocalizedDescriptionKey: "View ID must not be empty"
        ])

        static let invalidViewIDEventEncoding = NSError(domain: "EventEncoding", code: -1, userInfo: [
            NSLocalizedDescriptionKey: "View ID must not be empty"
        ])

        static let incompatibleInternalData = NSError(domain: "IncompatibleInternalData", code: -1, userInfo: [
            NSLocalizedDescriptionKey: "Incompatible internal data"
        ])

        static let storeInitialization = NSError(domain: "NSManagedObjectContext", code: 9, userInfo: [
            NSLocalizedDescriptionKey: "Store is not ready"
        ])
    }
}
