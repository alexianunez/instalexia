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

enum ParserError: Error {
    case MalformedData
}

struct Parser {
    
    static func parsePhotos(jsonData: [String: AnyObject]) -> [Photo]?
    {
        guard let data = jsonData["data"] as? [AnyObject]
            else { return nil }
        
        var photos: [Photo] = []
        for item in data {
            if let photoDict = item as? [String: AnyObject] {
                let photo = Photo(dict: photoDict)
                photos.append(photo)
            }
        }
        return photos
    }
    
    
    
}
