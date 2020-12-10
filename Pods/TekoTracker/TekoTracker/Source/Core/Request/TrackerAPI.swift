//
//  TrackerAPI.swift
//  Alamofire
//
//  Created by Dung Nguyen on 7/18/19.
//

import Alamofire

struct TrackerEnviroment: RequestEnvironment {
    let baseURL: URL
}

enum TrackerAPI: RequestAPI {
    case uploadOne
    case uploadMany
    case uploadException
    case syncTime
    case count

    var endPoint: String {
        switch self {
        case .uploadOne:
            return "/api/v2/users/log"
        case .uploadMany:
            return "/api/v2/users/logs"
        case .uploadException:
            return "/api/v2/exception"
        case .syncTime:
            return "/api/now"
        case .count:
            return "/api/count"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .uploadOne, .uploadMany, .uploadException, .count:
            return .post
        case .syncTime:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .uploadOne, .uploadMany, .uploadException, .count:
            return JSONEncoding.default
        case .syncTime:
            return URLEncoding.default
        }
    }
}
