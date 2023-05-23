//
//  NetworkRequests.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 22/05/2023.
//

import Foundation

struct Undefined: Decodable {}

extension Network {
    
    
    /* ----- AUTH ----- */
    
    func login(loginDto: LoginDto) async throws -> AuthResponseDto {
        let body = try! encoder.encode(loginDto)
        return try await sendRequest(params: RequestParameters(path: Endpoints.POSTLogin, method: .post), bodyData: body, isAuth: false)
    }
    
    /* ----- TRANSACTIONS ----- */

    func getTransactions() async throws -> [TransactionDto] {
        return try await sendRequest(params: RequestParameters(path: Endpoints.GETTransactions, method: .get), bodyData: nil)
    }
    
    func postTransaction(transactionDto: TransactionDto) async throws -> TransactionDto {
        let body = try! encoder.encode(transactionDto)
        return try await sendRequest(params: RequestParameters(path: Endpoints.POSTTransactions, method: .post), bodyData: body)
    }
    

    /* ----- PROFILE ----- */

    func getCurrentUser() async throws -> UserDto {
        return try await sendRequest(params: RequestParameters(path: Endpoints.GETMe, method: .get), bodyData: nil)
    }

}

/*
 
 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im56ZXJiaWJAZGV2LWlkLmZyIiwiaWF0IjoxNjg0ODI4Nzc0fQ.hCtCbjsQfnTBJ3R-SslXb_1rWK-59plpsxib7Lw46pg
 
 */
