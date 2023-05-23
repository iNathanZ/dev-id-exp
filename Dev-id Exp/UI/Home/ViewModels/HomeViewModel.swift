//
//  HomeViewModel.swift
//  Dev-id Exp
//
//  Created by Nathan ZERBIB on 23/05/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var userManager: UserManager = .shared
    
}
