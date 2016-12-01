//
//  TagSearchViewModel.swift
//  instalexia
//
//  Created by Alexia Nunez on 12/1/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TagSearchViewModel: ViewModel {
    
    var tagPhotos: Variable<[Photo]> = Variable([])

    override func setupBindings() {
        
        Photos.tagPhotos
        .asObservable()
        .bindTo(tagPhotos)
        .addDisposableTo(disposeBag)
        
    }
    
    func getTagPhotos() {
        Photos.getPhotos(type: .Tag(searchTerm: "christmas"))
    }
}
