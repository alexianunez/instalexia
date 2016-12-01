//
//  Photo.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/15/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum PhotoDataKeys: String {

    case Caption = "caption"
    case Images = "images"
    case ImagesThumb = "thumbnail"
    case ImagesLowRes = "low_resolution"
    case StandardRes = "standard_resolution"
    case Likes = "likes"
    case LikesCount = "count"
    case PhotoId = "id"
    case Text = "text"
    case URL = "url"
}

struct Photo {
    
    var photoId: Int = 0
    var likes: Int = 0
    var liked: Bool = false
    var thumbnailUrl: String = ""
    var standardUrl: String = ""
    var lowResUrl: String = ""
    var text: String = ""
    
    init (dict: [String: AnyObject]) {
        // Caption
        if let captionInfo = dict[PhotoDataKeys.Caption.rawValue] as? [String: AnyObject] {
            self.text = captionInfo[PhotoDataKeys.Text.rawValue] as? String ?? ""
        }
        // Likes
        if
            let likesInfo = dict[PhotoDataKeys.Likes.rawValue] as? [String: AnyObject],
            let likeValue = likesInfo[PhotoDataKeys.LikesCount.rawValue] as? String,
            let likesInt: Int = Int(likeValue) {
            self.likes = likesInt
        }
        // Thumbnail
        if
            let imagesInfo = dict[PhotoDataKeys.Images.rawValue] as? [String: AnyObject],
            let thumbnailInfo = imagesInfo[PhotoDataKeys.ImagesThumb.rawValue] as? [String: AnyObject]
            {
                self.thumbnailUrl = thumbnailInfo["url"] as? String ?? ""
        }
    }
    
}

enum PhotosType {
    case Recent
    case Tag(searchTerm: String)
    case Location(lat: String, long: String)
}

struct Photos {
    
    static var recentPhotos: Variable<[Photo]> = Variable([])
    static var locationPhotos: Variable<[Photo]> = Variable([])
    static var tagPhotos: Variable<[Photo]> = Variable([])
    
    static func getPhotos(type: PhotosType) {
        switch type {
        case .Recent:
            API.getRecentPhotos()
        case .Location(let lat, let long):
            API.getLocationPhotos(lat: lat, long: long)
        case .Tag(let searchTerm):
            API.getTagPhotos(searchTerm: searchTerm)
        }
    }
    
}
