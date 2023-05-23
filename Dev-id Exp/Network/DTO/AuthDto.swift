//
//  AuthDto.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 22/05/2023.
//

import Foundation

struct LoginDto: Encodable {
    let email: String
    let password: String
}

struct RegisterDto: Encodable {
    let name: String
    let email: String
    let password: String
    let picture: String
    let money: Int
}

struct AuthResponseDto: Decodable {
    let token: String
    let user: UserDto
}
