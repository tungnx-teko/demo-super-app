//
//  TrackerController+URLSessionInjector.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 4/27/20.
//

import Foundation

extension TrackerController: URLSessionInjectorDelegate {
    func urlSessionInjector(_ injector: URLSessionInjector, didReceiveData dataTask: URLSessionDataTask, data: Data) {
        guard let url = dataTask.originalRequest?.url else { return }
        guard validateRequestURL(url) else { return } // Filter all non-tracker requests

        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let httpCode = (dataTask.response as? HTTPURLResponse)?.statusCode else { return }
            if 200..<300 ~= httpCode { return } // If response is successful, do nothing
            if config.blacklistHttpCode.contains(where: { $0 as? Int == httpCode}) { return }
            let errorCode = getErrorCode(from: json)
            let errorMessage = json["message"] as? String
            let body = (dataTask.originalRequest?.httpBody).flatMap { String(data: $0, encoding: .utf8) }

            let eventData = ErrorEventData(
                errorSource: .http,
                apiCall: url.absoluteString,
                apiPayload: body,
                httpResponseCode: httpCode,
                responseJson: String(data: data, encoding: .utf8),
                errorCode: errorCode ?? "",
                errorMessage: errorMessage ?? ""
            )
            let event = try Event(
                eventType: EventType.error,
                eventName: EventName.error,
                viewID: variableStore.lastScreenInfo?.viewID ?? "",
                data: eventData
            )
            send(event: event)
        } catch {
            #if !RELEASE || !PRODUCTION
            if config.logDebug {
                print("TekoTracker => Failed to initialize error event", error as NSError)
            }
            #endif
        }
    }

    @inlinable
    func getErrorCode(from json: [String: Any]) -> String? {
        return ["code", "error_code", "errorCode"]
            .compactMap { json[$0] as? String ?? (json[$0] as? Int).map(String.init) }
            .first
    }

    func urlSessionInjector(_ injector: URLSessionInjector, didFinishWithError dataTask: URLSessionDataTask, error: Error?) {
        guard let error = error, let url = dataTask.originalRequest?.url else { return }
        guard validateRequestURL(url) else { return } // Filter all non-tracker requests

        do {
            guard let httpCode = (dataTask.response as? HTTPURLResponse)?.statusCode else { return }
            let eventData = ErrorEventData(
                errorSource: .http,
                apiCall: url.absoluteString,
                apiPayload: nil,
                httpResponseCode: httpCode,
                errorCode: ((error as NSError?)?.code).map(String.init) ?? "",
                errorMessage: error.localizedDescription
            )
            let event = try Event(
                eventType: EventType.error,
                eventName: EventName.error,
                viewID: variableStore.lastScreenInfo?.viewID ?? "",
                data: eventData
            )
            send(event: event)
        } catch {
            #if !RELEASE || !PRODUCTION
            if config.logDebug {
                print("TekoTracker => Failed to initialize error event", error as NSError)
            }
            #endif
        }
    }

    @inlinable
    func validateRequestURL(_ url: URL) -> Bool {
        guard ["https", "http"].contains(url.scheme) else { return false } // Only https, http protocol
        if url.host == request.environment.baseURL.host { return false }
        if config.blacklistURL.contains(where: url.absoluteString.contains) { return false }
        if config.whitelistURL.isEmpty { return true }
        return config.whitelistURL.contains(where: url.absoluteString.contains)
    }
}
