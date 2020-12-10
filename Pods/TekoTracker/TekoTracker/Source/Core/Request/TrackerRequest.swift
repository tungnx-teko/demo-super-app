//
//  TrackerRequest.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 7/18/19.
//

import Alamofire
import RxSwift

protocol TrackerRequestProtocol {
    var environment: RequestEnvironment { get }
    func send(_ model: EventRequestParamProtocol) -> Observable<String>
    func send<T>(_ models: [T]) -> Observable<[String]> where T: EventRequestParamProtocol
    func sendError(_ model: EventRequestParamProtocol) -> Observable<String>
    func getServerTime() -> Observable<TimeInterval>
    func sendCount(_ params: EventCountParams) -> Observable<Int>
}

struct EventCountParams: Encodable {
    let appID: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case appID = "appId"
        case count
    }
}

final class TrackerRequest: RawHTTPRequest, TrackerRequestProtocol {
    typealias API = TrackerAPI

    let environment: RequestEnvironment
    let retryTimes: Int
    let logDebug: Bool
    lazy var sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.af.default
        let userAgent: HTTPHeader = {
            let info = Bundle.main.infoDictionary
            let foundExecutable = (info?[kCFBundleExecutableKey as String] as? String) ??
                (ProcessInfo.processInfo.arguments.first?.split(separator: "/").last.map(String.init))
            let executable = foundExecutable?
                .folding(options: .diacriticInsensitive, locale: nil)
                .replacingOccurrences(of: "Đ", with: "D")
                .replacingOccurrences(of: "đ", with: "d")
                ?? "Unknown"
            let bundle = info?[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
            let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
            let appBuild = info?[kCFBundleVersionKey as String] as? String ?? "Unknown"

            let osNameVersion: String = {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
                return "iOS \(versionString)"
            }()
            let trackingVersion: String = {
                guard
                    let afInfo = Bundle(for: TrackerRequest.self).infoDictionary,
                    let build = afInfo["CFBundleShortVersionString"]
                else { return "Unknown" }

                return "TekoTracker/\(build)"
            }()

            let userAgent = "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion)) \(trackingVersion)"
            return .userAgent(userAgent)
        }()
        configuration.headers = [
            .defaultAcceptEncoding,
            .defaultAcceptLanguage,
            userAgent
        ]
        return Alamofire.Session(configuration: configuration)
    }()

    init(environment: RequestEnvironment, retryTimes: Int = Constant.retryWhenFailed, logDebug: Bool) {
        self.environment = environment
        self.retryTimes = retryTimes
        self.logDebug = logDebug
    }

    func send(_ model: EventRequestParamProtocol) -> Observable<String> {
        Observable<Data>
            .deferred { try .just(model.asData()) }
            .flatMap { self.rawExecute(api: .uploadOne, body: $0) }
            .flatMap(handleResponse)
            .retry(retryTimes)
            .map { _ in model.originalID }
    }

    func send<T>(_ models: [T]) -> Observable<[String]> where T: EventRequestParamProtocol {
        Observable<Data>
            .deferred { try .just(models.asData()) }
            .flatMap { self.rawExecute(api: .uploadMany, body: $0) }
            .flatMap(handleResponse)
            .retry(retryTimes)
            .map { _ in models.map { $0.originalID } }
    }

    func getServerTime() -> Observable<TimeInterval> {
        rawExecute(api: .syncTime, body: nil)
            .flatMap(handleResponse)
            .retry(retryTimes)
            .compactMap ({
                data in
                if #available(iOS 13.0, *) {
                    return try JSONDecoder().decode(TimeInterval.self, from: data)
                } else {
                    return try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? TimeInterval
                }
            })
    }

    func sendError(_ model: EventRequestParamProtocol) -> Observable<String> {
        Observable<Data>
            .deferred { try .just(model.asData()) }
            .flatMap { self.rawExecute(api: .uploadException, body: $0) }
            .flatMap(handleResponse)
            .retry(retryTimes)
            .map { _ in model.originalID }
    }

    func sendCount(_ params: EventCountParams) -> Observable<Int> {
        Observable<Data>
            .deferred { try .just(params.asData()) }
            .flatMap { self.rawExecute(api: .count, body: $0) }
            .flatMap(handleResponse)
            .retry(retryTimes)
            .map { _ in params.count }
    }

    private func handleResponse(_ response: AFDataResponse<Data>) -> Observable<Data> {
        switch response.result {
        case .success(let data):
            #if !RELEASE || !PRODUCTION
            if logDebug, let data = response.data {
                print("TekoTracker => String represents", String(data: data, encoding: .utf8) as Any)
            }
            #endif
            return .just(data)
        case .failure(let error):
            #if !RELEASE || !PRODUCTION
            if logDebug {
                print("TekoTracker => Request error", error as NSError)
            }
            #endif
            return .error(error)
        }
    }

    func makeRequest(api: API, body: Data?) throws -> URLRequestConvertible {
        var headers = defaultHeaders
        if let extraHeaders = api.extraHeaders {
            if let _headers = headers {
                headers = HTTPHeaders(_headers.dictionary + extraHeaders.dictionary)
            } else {
                headers = extraHeaders
            }
        }

        let fullURL = environment.baseURL.appendingPathComponent(api.endPoint)

        #if !RELEASE || !PRODUCTION
        if logDebug, let data = body {
            Swift.print("TekoTracker => Event body", String(data: data, encoding: .utf8) as Any)
        }
        #endif

        var rawRequest = try URLRequest(url: fullURL, method: api.method, headers: headers)
        rawRequest.httpBody = body
        rawRequest.cachePolicy = api.cachePolicy
        rawRequest.timeoutInterval = api.cacheTimeoutInterval
        return rawRequest
    }
}
