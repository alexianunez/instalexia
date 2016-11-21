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
    
    override init() {
        super.init()
        self.setupBindings()
    }
    
    private func setupBindings() {
        
        User.id.asObservable()
            .subscribe {event in
                guard let id = event.element, id > 0 else { return }
                API.getRecentPhotos()
        }.addDisposableTo(disposeBag)
        
        User.recentPhotos.asObservable()
            .subscribe { (nextEvent) in
                print(nextEvent)
        }.addDisposableTo(disposeBag)
        
    }
}
