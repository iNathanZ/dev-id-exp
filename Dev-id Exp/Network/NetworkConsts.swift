//
//  NetworkConsts.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 22/05/2023.
//

import Foundation

enum NetworkConsts {
    static let LogDebug = true
    static let DefaultRequestTimeout: TimeInterval = 15.0
    static let AuthorizationHeader = "Authorization"
    static let ApiKeyHeader = "APIKey"
    static let UserAgentHeader = "User-Agent"
    static let ContentTypeHeader = "Content-Type"
    static let AcceptHeader = "Accept"
    static let JsonContentType = "application/json"
    static let baseURL = "http://91.121.81.111:1338/api#"
}

enum HttpMethods: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

}
