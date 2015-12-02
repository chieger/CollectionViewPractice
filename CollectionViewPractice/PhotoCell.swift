//
//  PhotoCell.swift
//  CollectionViewPractice
//
//  Created by Charles Hieger on 12/1/15.
//  Copyright © 2015 Charles Hieger. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    func setThumbnailImage(thumbnailImage: UIImage) {
        thumbImageView.image = thumbnailImage
    }




}
