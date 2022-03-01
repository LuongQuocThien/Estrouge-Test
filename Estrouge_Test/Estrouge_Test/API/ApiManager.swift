//
//  ApiManager.swift
//  Estrouge_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias Completion<Value> = (Result<Value>) -> Void
typealias APICompletion = (APIResult) -> Void

public enum APIResult {
    case success
    case failure(Error)
}

final class Api {

    public struct Error {
        public static let network = NSError(
            domain: NSCocoaErrorDomain, code: -999)
        public static let json = NSError(
            domain: NSCocoaErrorDomain, code: 3_840)
        public static let cancelRequest = NSError(
            domain: NSCocoaErrorDomain, code: 999)
        public static let connectionAbort: NSError = NSError(
            domain: NSPOSIXErrorDomain, code: 53)
        public static let connectionWasLost: NSError = NSError(
            domain: NSURLErrorDomain, code: -1_005)
        public static let requestTimeOut = NSError(
            domain: NSCocoaErrorDomain, code: -1_001)
        public static let errorNetwork = NSError(
            domain: NSCocoaErrorDomain, code: -1009)

    }
}

extension Alamofire.SessionManager{
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest
    {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData
            urlRequest.timeoutInterval = 10
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}

