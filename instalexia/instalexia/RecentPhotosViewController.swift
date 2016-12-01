//
//  RecentPhotosViewController.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/18/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class RecentPhotosViewController: PhotosCollectionViewController {
    
    let viewModel = RecentPhotosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRecentPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.recentPhotos
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
