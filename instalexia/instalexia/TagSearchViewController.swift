//
//  TagSearchViewController.swift
//  instalexia
//
//  Created by Alexia Nunez on 12/1/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class TagSearchViewController: PhotosCollectionViewController {
    
    let viewModel = TagSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTagPhotos()
    }
 
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.tagPhotos
            .asObservable()
            .bindTo(photosCollectionView.rx.items(cellIdentifier: "PhotoCell")) { _, photo, cell in
                
                guard let photoCell = cell as? PhotoCollectionViewCell else { return }
                photoCell.photo = photo
                
                let button = UIButton(type: .system)
                button.frame = cell.bounds
                cell.contentView.addSubview(button)
                button.rx.tap
                    .throttle(0.3, scheduler: MainScheduler.instance)
                    .subscribe(onNext: {[unowned self] in
                        self.viewModel.setPhotoLiked(photo: photo)
                    }).addDisposableTo(self.disposeBag)
                
            }.addDisposableTo(disposeBag)
        
    }
    
}
