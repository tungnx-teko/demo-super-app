//
//  TrackerConfig.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 1/14/20.
//

import Foundation

final class TrackerConfig: TrackerConfigurable, Decodable {
    let appID: String
    let schemaVersion: String
    let logServerURL: String
    let environment: String
    let manuallyLogViewController: Bool
    let retryWhenFailed: Int32
    let scheduleRetryFailure: Bool
    let logDebug: Bool
    let manuallyLogTrackingNames: [String]
    let blacklistURL: [String]
    let whitelistURL: [String]
    let blacklistHttpCode: [Any]

    enum CodingKeys: String, CodingKey {
        case appID = "APP_ID"
        case schemaVersion = "SCHEMA_VERSION"
        case logServerURL = "LOG_SERVER_URL"
        case environment = "ENVIRONMENT"
        case manuallyLogViewController = "MANUALLY_LOG_VIEW_CONTROLLER"
        case retryWhenFailed = "RETRY_WHEN_FAILED"
        case scheduleRetryFailure = "SCHEDULE_RETRY_FAILURE"
        case logDebug = "LOG_DEBUG"
        case manuallyLogTrackingNames = "MANUALLY_LOG_TRACKING_NAMES"
        case blacklistURL = "BLACKLIST_URL"
        case whitelistURL = "WHITELIST_URL"
        case blacklistHttpCode = "BLACKLIST_HTTP_CODE"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appID = try container.decode(String.self, forKey: .appID)
        self.schemaVersion = try container.decode(String.self, forKey: .schemaVersion)
        self.environment = try container.decode(String.self, forKey: .environment)
        self.manuallyLogViewController = try container.decode(Bool.self, forKey: .manuallyLogViewController)
        self.retryWhenFailed = try container.decodeIfPresent(Int32.self, forKey: .retryWhenFailed).map { max($0, 0) } ?? Int32(Constant.retryWhenFailed)
        self.scheduleRetryFailure = try container.decodeIfPresent(Bool.self, forKey: .scheduleRetryFailure) ?? false
        self.logDebug = try container.decodeIfPresent(Bool.self, forKey: .logDebug) ?? true
        self.manuallyLogTrackingNames = try container.decodeIfPresent([String].self, forKey: .manuallyLogTrackingNames) ?? []
        self.blacklistURL = try container.decodeIfPresent([String].self, forKey: .blacklistURL) ?? []
        self.whitelistURL = try container.decodeIfPresent([String].self, forKey: .whitelistURL) ?? []
        self.blacklistHttpCode = try container.decodeIfPresent([Int].self, forKey: .blacklistHttpCode) ?? []

        let logServerURL = try container.decodeIfPresent(String.self, forKey: .logServerURL)
        if let logServerURL = logServerURL, !logServerURL.isEmpty {
            self.logServerURL = logServerURL
        } else {
            switch environment.lowercased() {
            case "production",
                 "release",
                 "live":
                self.logServerURL = "https://tracking.tekoapis.com"
            default:
                self.logServerURL = "https://tracking.develop.tekoapis.net"
            }
        }
    }

    // Unit testing
    init(appID: String, schemaVersion: String = "1.0.0", logServerURL: String, environment: String, manuallyLogViewController: Bool = false, retryWhenFailed: Int32 = Int32(Constant.retryWhenFailed),
         scheduleRetryFailure: Bool = false, logDebug: Bool = false, manuallyLogTrackingNames: [String] = [], blacklistURL: [String] = [], whitelistURL: [String] = [], blacklistHttpCode: [Int] = []) {
        self.appID = appID
        self.schemaVersion = schemaVersion
        self.logServerURL = logServerURL
        self.environment = environment
        self.manuallyLogViewController = manuallyLogViewController
        self.retryWhenFailed = retryWhenFailed
        self.scheduleRetryFailure = scheduleRetryFailure
        self.logDebug = logDebug
        self.manuallyLogTrackingNames = manuallyLogTrackingNames
        self.blacklistURL = blacklistURL
        self.whitelistURL = whitelistURL
        self.blacklistHttpCode = blacklistHttpCode
    }
}
