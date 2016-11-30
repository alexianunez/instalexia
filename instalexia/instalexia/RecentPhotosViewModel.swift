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
    
    override init() {
        super.init()
        setupBindings()
        getRecentPhotos()
    }
    
    private func setupBindings() {
        Photos.recentPhotos
        .asObservable()
        .subscribe {
            guard let photos = $0.element else { return }
            self.recentPhotos.value = photos
        }.addDisposableTo(disposeBag)
    }
    
    func getRecentPhotos() {
        Photos.getRecentPhotos()
    }
}
