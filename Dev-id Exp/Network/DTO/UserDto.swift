//
//  UserDto.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 22/05/2023.
//

import Foundation

struct UserDto: Decodable {
    let name: String
    let email: String
    let picture: String
    let money: Int
}
