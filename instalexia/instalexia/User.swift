//
//  User.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/15/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum UserDataKeys: String {
    case Bio = "bio"
    case Data = "data"
    case ID = "id"
    case Fullname = "fullname"
    case ProfilePictureURL = "profile_picture"
    case Username = "username"
    case Website = "website"
}

struct User {
    
    static var id: Variable<Int> = Variable(0)
    static var userName: Variable<String> = Variable("")
    static var fullName: Variable<String> = Variable("")
    static var profilePictureUrl: Variable<String> = Variable("")
    static var bio: Variable<String> = Variable("")
    static var website: Variable<String> = Variable("")
    static var recentPhotos: Variable<[String]> = Variable([])
    
    static func createUserWithJSON(jsonData: [String: AnyObject]) {
        guard
        let data = jsonData[UserDataKeys.Data.rawValue] as? [String: AnyObject],
        let id = data[UserDataKeys.ID.rawValue] as? String,
        let idInt: Int = Int(id)
            else { return }

        User.id.value = idInt
        User.userName.value = data[UserDataKeys.Username.rawValue] as? String ?? ""
        User.fullName.value = data[UserDataKeys.Fullname.rawValue] as? String ?? ""
        User.bio.value = data[UserDataKeys.Bio.rawValue] as? String ?? ""
        User.profilePictureUrl.value = data[UserDataKeys.ProfilePictureURL.rawValue] as? String ?? ""
        User.website.value = data[UserDataKeys.Website.rawValue] as? String ?? ""
    }
    
    func getLatestPhotos() {
        API.getRecentPhotos()
    }
}
