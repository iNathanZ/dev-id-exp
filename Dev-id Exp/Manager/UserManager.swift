//
//  UserManager.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 23/05/2023.
//

import Foundation

class UserManager: ObservableObject {
    
    static let shared = UserManager()
    
    @Published var currentUser: UserDto? = nil
    
    func setUser(newUser: UserDto) {
        currentUser = newUser
    }
    
}
