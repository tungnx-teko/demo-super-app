//
//  Util.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/18/19.
//

import Reachability

func formatTimezoneOffset(_ seconds: Int) -> String {
    let interval = abs(seconds)
    let sign = interval == 0 ? 0 : seconds / interval
    let s: String
    if sign == 0 {
        s = ""
    } else if sign > 0 {
        s = "+"
    } else {
        s = "-"
    }
    let minutes = (interval / 60) % 60
    let hours = interval / 3600
    return s + String(format: "%02d:%02d", hours, minutes)
}

func formatNetworkConnection(_ connection: Reachability.Connection) -> String {
    switch connection {
    case .cellular:
        return "3G/4G"
    default:
        return connection.description
    }
}
