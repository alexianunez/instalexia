//
//  RecentPhotosViewMode..swift
//  instalexia
//
//  Created by Alexia Nunez on 11/18/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

final class RecentPhotosViewModel: ViewModel {
    
    var recentPhotos: Variable<[Photo]> = Variable([])
    
    override func setupBindings() {
        
        recentPhotos
        .asObservable()
        .bindTo(Photos.recentPhotos)
        .addDisposableTo(disposeBag)
        
    }
    
    func getRecentPhotos() {
        Photos.getPhotos(type: .Recent)
    }
    
}
