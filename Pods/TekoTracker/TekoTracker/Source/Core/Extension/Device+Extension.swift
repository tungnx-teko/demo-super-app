//
//  Device+Extension.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/18/19.
//

import Foundation
import DeviceKit

struct NetworkInterfaceNames {
    static let wifi = ["en0"]
    static let wired = ["en2", "en3", "en4"]
    static let cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
    static let supported = wifi + wired + cellular
}

extension Device {
    var fullSystemName: String? {
        guard let name = systemName, let version = systemVersion else {
            return nil
        }
        return "\(name) \(version)"
    }

    var ipAddress: (address: String?, ipv6: Bool) {
        var ipAddress: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        var ipv6: Bool = false

        if getifaddrs(&ifaddr) == 0 {
            var pointer = ifaddr

            while pointer != nil {
                defer { pointer = pointer?.pointee.ifa_next }

                guard
                    let interface = pointer?.pointee,
                    interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) || interface.ifa_addr.pointee.sa_family == UInt8(AF_INET6),
                    let interfaceName = interface.ifa_name,
                    let interfaceNameFormatted = String(cString: interfaceName, encoding: .utf8),
                    NetworkInterfaceNames.supported.contains(interfaceNameFormatted)
                    else { continue }

                ipv6 = interface.ifa_addr.pointee.sa_family == UInt8(AF_INET6)
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))

                getnameinfo(interface.ifa_addr,
                            socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname,
                            socklen_t(hostname.count),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST)

                guard
                    let formattedIpAddress = String(cString: hostname, encoding: .utf8),
                    !formattedIpAddress.isEmpty
                    else { continue }

                ipAddress = formattedIpAddress
                break
            }

            freeifaddrs(ifaddr)
        }

        return (address: ipAddress, ipv6: ipv6)
    }
}
