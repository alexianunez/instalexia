//
//  LocationPhotosViewModel.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/30/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

class LocationPhotosViewModel: ViewModel {
    
    var locationPhotos: Variable<[Photo]> = Variable([])

    override func setupBindings() {
        
        Photos.locationPhotos
        .asObservable()
        .bindTo(locationPhotos)
        .addDisposableTo(disposeBag)
        
    }
    
    func getLocationPhotos() {
        Photos.getPhotos(type: .Location(lat: "48.858844", long: "2.294351"))
    }
    
}
