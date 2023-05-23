//
//  RequestError.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 22/05/2023.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case badRequest
    
    var customMessage: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Unauthorized action"
        default:
            return "Unknown error"
        }
    }
}
