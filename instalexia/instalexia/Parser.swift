//
//  Parser.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/21/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


struct Parser {
    
    static func parsePhotos(jsonData: [String: AnyObject]) {
        guard let data = jsonData["data"] as? [AnyObject] else { return }
        for item in data {
            if let photoDict = item as? [String: AnyObject] {
                let photo = Photo(dict: photoDict)
                print(photo.text)
                print(photo.likes)
                print(photo.thumbnailUrl)
            }
        }
    }
}
