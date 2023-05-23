//
//  Network.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 22/05/2023.
//

import Foundation
import Combine

class Network: ObservableObject {
    
    static let shared = Network()
    
    internal let decoder = JSONDecoder()
    internal let encoder = JSONEncoder()
    private let defaultUrlSessionConfiguration: URLSessionConfiguration
    private var session: URLSession
    private var authSession: URLSession
    
    init() {
        defaultUrlSessionConfiguration = .default
        defaultUrlSessionConfiguration.timeoutIntervalForRequest = NetworkConsts.DefaultRequestTimeout
        defaultUrlSessionConfiguration.httpAdditionalHeaders = [
            NetworkConsts.AcceptHeader: NetworkConsts.JsonContentType,
            NetworkConsts.ContentTypeHeader: NetworkConsts.JsonContentType,
            NetworkConsts.ApiKeyHeader: "",
        ]
        session = URLSession(configuration: defaultUrlSessionConfiguration, delegate: nil, delegateQueue: .main)
        authSession = URLSession(configuration: defaultUrlSessionConfiguration, delegate: nil, delegateQueue: .main)
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            }
            return date
        })
    }

    func initAuthenticatedSession(with authorizationHeader: String) {
        defaultUrlSessionConfiguration.httpAdditionalHeaders?[NetworkConsts.AuthorizationHeader] = "Bearer \(authorizationHeader)"
        authSession = URLSession(configuration: defaultUrlSessionConfiguration, delegate: nil, delegateQueue: .main)
    }

    
    internal func sendRequest<T: Decodable>(params: RequestParameters, bodyData: Data?, isAuth: Bool = true) async throws -> T {
    
        guard let url = URL(string: NetworkConsts.baseURL + params.path) else { throw RequestError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = params.method.rawValue
        let reqSession = isAuth ? authSession : session
        
        if let vBody = bodyData { request.httpBody = vBody }
        
        print("Calling \(request)")
//            dump(request)
        if let body = request.httpBody, let bodyStr = String(data: body, encoding: .utf8) {
            print("with body: \(bodyStr)")
        }
        
        do {
            let (data, response) = try await reqSession.data(for: request)
            
            let readableData = String(data: data, encoding: .utf8) ?? "no data"
            print("Data \(readableData) Response \(String(describing: response))")
            
            guard let response = response as? HTTPURLResponse else { throw RequestError.noResponse }
            switch response.statusCode {
            case 200...299:
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    print("Failed to decode JSON: \(error)")
                    throw RequestError.unknown
                }
            case 400:
                throw RequestError.badRequest
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unknown
            }
        } catch {
            print("Failed to decode JSON: \(error)")
            throw RequestError.unknown
        }
        
    }
    
}
