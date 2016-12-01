//
//  PhotosViewController.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/18/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class PhotosViewController: ViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        //Photos.getRecentPhotos()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBindings() {
        
//        viewModel.recentPhotos
//            .asObservable()
//            .bindTo(photosCollectionView.rx.items(cellIdentifier: "PhotoCell")) { _, photo, cell in
//                
//                guard let photoCell = cell as? PhotoCollectionViewCell else { return }
//                photoCell.photo = photo
//                
//                let button = UIButton(type: .system)
//                button.frame = cell.bounds
//                cell.contentView.addSubview(button)
//                button.rx.tap
//                    .throttle(0.3, scheduler: MainScheduler.instance)
//                    .subscribe(onNext: {[unowned self] in
//                        self.viewModel.setPhotoLiked(photo: photo)
//                    }).addDisposableTo(self.disposeBag)
//                
//            }.addDisposableTo(disposeBag)
        
    }
    
    //MARK: - Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let itemWidth = (photosCollectionView.frame.width - (numberOfColumns - 1)) / numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}
