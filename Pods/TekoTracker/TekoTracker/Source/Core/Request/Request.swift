//
//  Request.swift
//  TekoTracker
//
//  Created by Robert on 7/17/19.
//

import Alamofire
import RxSwift

protocol RawHTTPRequest: Request {
    associatedtype API: RequestAPI

    var session: Alamofire.Session { get }

    /// Override this following method if authorization is required
    var defaultHeaders: HTTPHeaders? { get }

    func makeRequest(api: API, body: Data?) throws -> URLRequestConvertible
}

// MARK: - Default
extension RawHTTPRequest {
    var defaultHeaders: HTTPHeaders? { nil }

    var session: Alamofire.Session { .default }
}

// MARK: - Convenience
extension RawHTTPRequest {
    func rawExecute(api: API, body: Data?) -> Observable<AFDataResponse<Data>> {
        .create {
            subscribe in
            var dataRequest: DataRequest!
            do {
                let request = try self.makeRequest(api: api, body: body)
                dataRequest = self.session.request(request)
                dataRequest.validate().responseData {
                    response in
                    subscribe.onNext(response)
                    subscribe.onCompleted()
                }
            } catch {
                subscribe.onError(error)
            }
            return Disposables.create()
        }
    }
}
