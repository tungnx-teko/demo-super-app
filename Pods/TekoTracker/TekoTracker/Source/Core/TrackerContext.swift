//
//  TrackerContext.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/19/19.
//

import Foundation
import CoreTelephony
import DeviceKit
import Reachability

protocol TrackerContextProtocol {
    var appID: String { get }
    var phoneNumber: String? { get }
    var visitor: Visitor { get }
    var currentNetworkConnectionInfo: NetworkConnectivityInfo? { get }
    var appVersion: String? { get }
    var frameworkVersion: String? { get }
    var deviceID: String? { get }
    func startListener()
    func stopListener()
    func use(userID: String, phoneNumber: String?)
    func getNetworkConnectivityInfo(carrier: CTCarrier?) -> NetworkConnectivityInfo
    func generateSession() -> Session
}

extension TrackerContextProtocol {
    var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var frameworkVersion: String? {
        Bundle(for: TrackerContext.self).infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var deviceID: String? {
        UIDevice.current.identifierForVendor?.uuidString
    }
}

protocol TrackerContextDelegate: class {
    func networkDidBecomeReachable(_ context: TrackerContext)
    func networkDidResignReachable(_ context: TrackerContext)
}

final class TrackerContext: TrackerContextProtocol {
    let device: Device
    let timezone: TimeZone
    let networkInfo: CTTelephonyNetworkInfo
    let reachability: Reachability?

    let appID: String
    var phoneNumber: String?
    lazy var visitor = Visitor(clientID: deviceID ?? "", userID: "")

    private var carrier: CTCarrier?
    private(set) var currentNetworkConnectionInfo: NetworkConnectivityInfo?

    weak var delegate: TrackerContextDelegate?

    init(appID: String) {
        self.appID = appID
        self.device = Device.current
        self.timezone = TimeZone.current
        self.networkInfo = CTTelephonyNetworkInfo()
        self.reachability = try? Reachability()
    }

    func startListener() {
        self.reachability?.whenReachable = {
            [weak self] _ in
            guard let self = self else { return }
            self.currentNetworkConnectionInfo = self.getNetworkConnectivityInfo(carrier: self.carrier)
            self.delegate?.networkDidBecomeReachable(self)
        }
        self.reachability?.whenUnreachable = {
            [weak self] _ in
            guard let self = self else { return }
            self.delegate?.networkDidResignReachable(self)
        }
        try? self.reachability?.startNotifier()
        if #available(iOS 12.0, *) {
            self.carrier = networkInfo.serviceSubscriberCellularProviders?.first?.1
        } else {
            networkInfo.subscriberCellularProviderDidUpdateNotifier = {
                [weak self] carrier in
                guard let self = self else { return }
                self.carrier = carrier
                self.currentNetworkConnectionInfo = self.getNetworkConnectivityInfo(carrier: carrier)
            }
            self.carrier = networkInfo.subscriberCellularProvider
        }
        self.currentNetworkConnectionInfo = getNetworkConnectivityInfo(carrier: carrier ?? CTCarrier())
    }

    func stopListener() {
        self.reachability?.whenReachable = nil
        self.reachability?.stopNotifier()
        if #available(iOS 12.0, *) {} else {
            self.networkInfo.subscriberCellularProviderDidUpdateNotifier = nil
        }
    }

    func use(userID: String, phoneNumber: String?) {
        self.visitor = Visitor(clientID: deviceID ?? "", userID: userID)
        self.phoneNumber = phoneNumber
        self.currentNetworkConnectionInfo = getNetworkConnectivityInfo(carrier: carrier ?? CTCarrier())
    }

    func getNetworkConnectivityInfo(carrier: CTCarrier?) -> NetworkConnectivityInfo {
        NetworkConnectivityInfo(
            phoneNumber: phoneNumber ?? "",
            carrierName: carrier?.carrierName ?? carrier?.mobileNetworkCode ?? "unknown",
            networkType: reachability == nil ? "" : formatNetworkConnection(reachability!.connection)
        )
    }

    func generateSession() -> Session {
        let now = Date().timeIntervalSince1970

        return Session(
            id: UUID().uuidString.lowercased(),
            lastActiveAt: now,
            createdAt: now,
            offset: formatTimezoneOffset(timezone.secondsFromGMT()),
            timezone: timezone.identifier,
            osVersion: device.systemVersion ?? "unknown",
            branchName: device.model ?? "unknown",
            modelName: device.realDevice.description,
            resolution: "\(Int(UIScreen.main.nativeBounds.width))x\(Int(UIScreen.main.nativeBounds.height))"
        )
    }
}
