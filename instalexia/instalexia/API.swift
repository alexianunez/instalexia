//
//  API.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/15/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxAlamofire
import KeychainSwift


enum APIConstants {
    
    static let baseURL: String = "https://api.instagram.com"
    static let apiVersion: String = "v1"
    static let clientID: String = "45146358267843dc87a9eb738b771e77"
    static let callbackURL: String = "https://awomannamedalexia.com"
    
    enum Endpoints {
        case Users
        case Location(lat: Float, long: Float)
        case Tags(searchTerm: String)
        case Login
        
        var fullURL: String {
            switch self {
            case .Users:
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self/media/recent/"
            case .Location(let lat, let long):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/media/search?lat=\(lat)&lng=\(long)&access_token="
            case .Tags(let searchTerm):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self/media/recent/\(searchTerm)"
            case .Login:
                return "\(APIConstants.baseURL)/oauth/authorize/?client_id=\(APIConstants.clientID)&redirect_uri=\(APIConstants.callbackURL)&response_type=token"
            }
        }
    }
}

final class API {
    
    // Public variables
    static var needsLogin: Variable<Bool> = Variable(false)
    
    // Private variables
    static private let keychain: KeychainSwift = KeychainSwift(keyPrefix: "com.instalexia")
    static private var authToken: String?
    
    static func hasAuthToken() -> Bool {
        return authToken != nil ? true : false
    }

    static func startUp() {
        API.authToken = API.keychain.get("authToken")
    }
    static func setAuthToken(token: String) {
        API.authToken = token
        API.keychain.set(token, forKey: "authToken")
    }
    
    
    
}
