//
//  PhotoCollectionViewCell.swift
//  instalexia
//
//  Created by Alexia Nunez on 11/29/16.
//  Copyright © 2016 Alexia Nunez. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var photo: Photo? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func configureCell() {
        
        if let photo = photo {
            loadPhoto(photoUrl: photo.thumbnailUrl)
        }
        
    }
    
    private func loadPhoto(photoUrl: String) {
        let imageView = UIImageView(frame: self.bounds)
        let url = URL(string: photoUrl)
        imageView.kf.setImage(with: url)
        self.contentView.addSubview(imageView)
    }
    
}
