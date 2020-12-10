//
//  Preferences.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Foundation

protocol VariableStoreProtocol {
    var distanceToServerTime: TimeInterval { set get }
    var isValidDistanceToServerTime: Bool { get }
    var lastScreenInfo: ScreenInfo? { set get }
    func popLastScreenInfo()
    func retrieve()
    func commit()
    func clean()
}

class ScreenInfo {

    struct Extra {
        let first: String?
        let second: String?
        let third: String?
        let fourth: String?
        let fifth: String?

        init(first: String?, second: String?, third: String?, fourth: String?, fifth: String?) {
            self.first = first
            self.second = second
            self.third = third
            self.fourth = fourth
            self.fifth = fifth
        }

        init(_ dict: [String: Any]) {
            self.first = dict["first"] as? String
            self.second = dict["second"] as? String
            self.third = dict["third"] as? String
            self.fourth = dict["fourth"] as? String
            self.fifth = dict["fifth"] as? String
        }

        func toDict() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["first"] = first
            dict["second"] = second
            dict["third"] = third
            dict["fourth"] = fourth
            dict["fifth"] = fifth
            return dict
        }

        func toFlattenExtraAttribute() -> FlattenExtraAttribute {
            .init(first: first, second: second, third: third, fourth: fourth, fifth: fifth)
        }
    }

    var viewID: String
    let name: String
    let referrer: String
    let contentType: String?
    let title: String?
    let href: String?
    let extra: Extra?
    let shouldHoldToTrackOnLoad: Bool
    let navigationStart: TimeInterval
    var loadEventEnd: TimeInterval
    var isConfirmed: Bool

    init(viewID: String, name: String, referrer: String, contentType: String?, title: String?, href: String?, extra: Extra?, shouldHoldToTrackOnLoad: Bool, navigationStart: TimeInterval, loadEventEnd: TimeInterval) {
        self.viewID = viewID
        self.name = name
        self.referrer = referrer
        self.contentType = contentType
        self.title = title
        self.href = href
        self.extra = extra
        self.shouldHoldToTrackOnLoad = shouldHoldToTrackOnLoad
        self.navigationStart = navigationStart
        self.loadEventEnd = loadEventEnd
        self.isConfirmed = false
    }

    init(_ dict: [String: Any]) {
        self.viewID = dict["viewID"] as! String
        self.name = dict["name"] as! String
        self.referrer = dict["referrer"] as? String ?? ""
        self.contentType = dict["contentType"] as? String
        self.title = dict["title"] as? String
        self.href = dict["href"] as? String
        self.extra = (dict["extra"] as? [String: Any]).map(Extra.init)
        self.shouldHoldToTrackOnLoad = dict["shouldHoldToTrackOnLoad"] as? Bool ?? false
        self.navigationStart = dict["navigationStart"] as? TimeInterval ?? 0
        self.loadEventEnd = dict["loadEventEnd"] as? TimeInterval ?? 0
        self.isConfirmed = dict["isConfirmed"] as? Bool ?? true
    }

    func toDict() -> [String: Any] {
        var dict: [String: Any] = [
            "viewID" : viewID,
            "name": name,
            "referrer": referrer
        ]
        dict["contentType"] = contentType
        dict["title"] = title
        dict["href"] = href
        dict["extra"] = extra?.toDict()
        dict["shouldHoldToTrackOnLoad"] = shouldHoldToTrackOnLoad
        dict["navigationStart"] = navigationStart
        dict["loadEventEnd"] = loadEventEnd
        dict["isConfirmed"] = isConfirmed
        return dict
    }
}

final class VariableStore: VariableStoreProtocol {
    let userDefault: UserDefaults

    var isWaitingForRetrieve = true

    var _distanceToServerTime: TimeInterval?
    var distanceToServerTime: TimeInterval {
        set { _distanceToServerTime = newValue }
        get { _distanceToServerTime ?? 0 }
    }

    var isValidDistanceToServerTime: Bool { _distanceToServerTime != nil }

    var lastScreenInfo: ScreenInfo? {
        set {
            if let screenInfo = newValue {
                if isWaitingForRetrieve {
                    tempScreenInfos.append(screenInfo)
                } else {
                    screenInfos.append(screenInfo)
                }
            }
        }
        get { isWaitingForRetrieve ? tempScreenInfos.last : screenInfos.last }
    }
    var screenInfos: [ScreenInfo] = []
    var tempScreenInfos: [ScreenInfo] = []

    enum Keys: String {
        // v1
        case trackingScreenViewID = "kTrackingScreenViewID"
        case lastScreenViewName = "kLastScreenViewName"
        // v2
        case screenInfos = "kScreenInfos"
    }

    init() {
        self.userDefault = UserDefaults(suiteName: "vn.teko.ios.tracker") ?? .standard
    }

    func popLastScreenInfo() {
        if isWaitingForRetrieve {
            _ = tempScreenInfos.popLast()
        } else {
            _ = screenInfos.popLast()
        }
    }

    func retrieve() {
        if isWaitingForRetrieve {
            self.screenInfos = userDefault.array(forKey: Keys.screenInfos.rawValue)?
                .compactMap { $0 as? [String: Any] }
                .map(ScreenInfo.init) ?? [] + tempScreenInfos
            self.tempScreenInfos = []
        } else {
            self.screenInfos = userDefault.array(forKey: Keys.screenInfos.rawValue)?
            .compactMap { $0 as? [String: Any] }
            .map(ScreenInfo.init) ?? []
        }
        self.isWaitingForRetrieve = false
    }

    func commit() {
        let data = screenInfos.map { $0.toDict() }
        if data.isEmpty {
            userDefault.set(nil, forKey: Keys.screenInfos.rawValue)
        } else {
            userDefault.set(data, forKey: Keys.screenInfos.rawValue)
        }
        self.isWaitingForRetrieve = true
    }

    func clean() {
        screenInfos.removeAll()
        commit()
    }
}
