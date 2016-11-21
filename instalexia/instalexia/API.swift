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
import Alamofire

enum APIError: Error {
    case UnknownError
    case MalformedData
    case RequestTimedOut
}

enum APIConstants {
    
    static let baseURL: String = "https://api.instagram.com"
    static let apiVersion: String = "v1"
    static let clientID: String = "45146358267843dc87a9eb738b771e77"
    static let callbackURL: String = "https://awomannamedalexia.com"
    
    enum Endpoints {
        case UserInfo
        case Recent
        case Location(lat: Float, long: Float)
        case Tags(searchTerm: String)
        case Login
        
        var fullURL: String {
            switch self {
            case .UserInfo:
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self"
            case .Recent:
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self/media/recent"
            case .Location(let lat, let long):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/media/search?lat=\(lat)&lng=\(long)"
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
    static private let disposeBag = DisposeBag()
    
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
    
    // No need to return anything, since the values are all subscribable
    static func getUserInfo() {
        API.callAPI(endPoint: .UserInfo)
        .asObservable()
        .subscribe { event in
            guard let jsonData = event.element as? [String: AnyObject] else { return }
            User.createUserWithJSON(jsonData: jsonData)
        }
        .addDisposableTo(disposeBag)
    }
    
    static func getRecentPhotos() {
        API.callAPI(endPoint: .Recent)
        .asObservable()
        .subscribe { event in
            print(event)
        }
        .addDisposableTo(disposeBag)
    }

    static private func callAPI(endPoint: APIConstants.Endpoints) -> Observable<Any> {
        guard
            let accessToken = API.authToken,
            let url = URL(string: "\(endPoint.fullURL)?access_token=\(accessToken)")
        else { return Observable.error(APIError.UnknownError) }
        
        return URLSession.shared.rx.json(url: url)
        .observeOn(MainScheduler.instance)
    }
}
