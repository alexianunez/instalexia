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
        case Location(lat: String, long: String)
        case Tags(searchTerm: String)
        case Login
        case Like(mediaId: Int)
        
        var fullURL: String {
            switch self {
            case .UserInfo:
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self"
            case .Recent:
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/users/self/media/recent"
            case .Location(let lat, let long):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/media/search?lat=\(lat)&lng=\(long)"
            case .Tags(let searchTerm):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/tags/\(searchTerm)/media/recent"
            case .Login:
                return "\(APIConstants.baseURL)/oauth/authorize/?client_id=\(APIConstants.clientID)&redirect_uri=\(APIConstants.callbackURL)&response_type=token"
            case .Like(let mediaId):
                return "\(APIConstants.baseURL)/\(APIConstants.apiVersion)/media/\(mediaId)/likes"
            }
        }
    }
}

let authTokenKey = "authToken"
let prefix = "com.instalexia"

final class API {
    
    // Public variables
    static var needsLogin: Variable<Bool> = Variable(false)
    
    // Private variables
    static private let keychain: KeychainSwift = KeychainSwift(keyPrefix: prefix)
    static private var authToken: String?
    static private let disposeBag = DisposeBag()
    
    static func hasAuthToken() -> Bool {
        return authToken != nil ? true : false
    }

    static func startUp() {
        API.authToken = API.keychain.get(authTokenKey)
    }
    static func setAuthToken(token: String) {
        API.authToken = token
        API.keychain.set(token, forKey: authTokenKey)
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
                guard
                    let jsonData = event.element as? [String: AnyObject],
                    let photos = Parser.parsePhotos(jsonData: jsonData)
                else { return }
                Photos.recentPhotos.value = photos
        }.addDisposableTo(disposeBag)
    }
    
    static func getTagPhotos(searchTerm: String) {
        API.callAPI(endPoint: .Tags(searchTerm: searchTerm))
            .asObservable()
            .subscribe { event in
                guard
                    let jsonData = event.element as? [String: AnyObject],
                    let photos = Parser.parsePhotos(jsonData: jsonData)
                    else { return }
                Photos.tagPhotos.value = photos
            }.addDisposableTo(disposeBag)
    }
    
    static func getLocationPhotos(lat: String, long: String) {
        API.callAPI(endPoint: .Location(lat: lat, long: long))
        .asObservable()
        .subscribe { event in
            guard
                let jsonData = event.element as? [String: AnyObject],
                let photos = Parser.parsePhotos(jsonData: jsonData)
                else { return }
            Photos.locationPhotos.value = photos
        }.addDisposableTo(disposeBag)
    }
    
    static private func callAPI(endPoint: APIConstants.Endpoints) -> Observable<Any> {
        let separator: String = endPoint.fullURL.contains("?") ? "&" : "?"
        guard
            let accessToken = API.authToken,
            let url = URL(string: "\(endPoint.fullURL)\(separator)access_token=\(accessToken)")
        else { return Observable.error(APIError.UnknownError) }
        return URLSession.shared.rx.json(url: url)
        .observeOn(MainScheduler.instance)
    }
    
}
