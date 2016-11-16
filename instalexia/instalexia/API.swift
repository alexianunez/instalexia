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

enum APIConstants {
    
    static let baseURL: String = "https://api.instagram.com"
    static let apiVersion: String = "v1"
    
    enum Endpoints {
        case Users
        case Location(lat: Float, long: Float)
        case Tags(searchTerm: String)
        
        var debugDescription: String {
            switch self {
            case .Users:
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self/media/recent/"
            case .Location(let lat, let long):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/media/search?lat=\(lat)&lng=\(long)&access_token="
            case .Tags(let searchTerm):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self/media/recent/\(searchTerm)"
            }
        }
}

class API {
    
    var authToken: String = ""
    
    
    // Needed functions
    
    func getAuthForUser() {
    
    }
        
}
    
    
    
}
