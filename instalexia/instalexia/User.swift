//
//  User.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/15/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation

struct User {
    let userName: String
    private let authToken: String
    
    init(userName: String, authToken: String) {
        self.userName = userName
        self.authToken = authToken
    }
    
    func isLoggedIn() -> Bool {
        return !self.authToken.isEmpty
    }
}
