//
//  RecentPhotosViewController.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/18/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import UIKit
import Kingfisher

final class RecentPhotosViewController: ViewController, UICollectionViewDelegateFlowLayout {
    
    let viewModel = RecentPhotosViewModel()

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        Photos.getRecentPhotos()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBindings() {
        
        viewModel.recentPhotos
        .asObservable()
        .bindTo(photosCollectionView.rx.items(cellIdentifier: "PhotoCell")) { _, photo, cell in
            self.configureCell(cell: cell, photoUrl: photo.thumbnailUrl)
            
        }
        .addDisposableTo(disposeBag)
    }
    
    private func configureCell(cell: UICollectionViewCell, photoUrl: String) {
        
        let imageView = UIImageView(frame: cell.bounds)
        let url = URL(string: photoUrl)
        imageView.kf.setImage(with: url)
        cell.contentView.addSubview(imageView)
        
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
