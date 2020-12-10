//
//  API.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Alamofire

/* Should use an enum struct to conform this protocol
 * Eg: enum Enviroment: RequestEnvironment {}
 */
protocol RequestEnvironment {
    var baseURL: URL { get }
}

protocol RequestAPI {
    var cachePolicy: URLRequest.CachePolicy { get }
    var cacheTimeoutInterval: TimeInterval { get }

    var endPoint: String { get }

    var method: HTTPMethod { get }
    var extraHeaders: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

extension RequestAPI {
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }

    var cacheTimeoutInterval: TimeInterval { 0 }

    var extraHeaders: HTTPHeaders? {
        [
            "Content-Type": "application/json"
        ]
    }

    var encoding: ParameterEncoding { URLEncoding.default }
}

protocol Request {
    var environment: RequestEnvironment { get }
}
