//
//  ViewModel.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/16/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    let disposeBag = DisposeBag()
    
    init() {
        self.setupBindings()
    }
    
    func setupBindings() {
        
    }
    
    func setPhotoLiked(photo: Photo) {
        print(photo.text)
    }
    
    func setPhotoUnliked(photo: Photo) {
        print(photo.text)
    }
    
}
