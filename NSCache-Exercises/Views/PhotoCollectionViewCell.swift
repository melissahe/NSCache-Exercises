//
//  FlickrCollectionViewCell.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var urlString = ""
    
    func configureCell(withPhoto photo: Photo) {
        
        //if image is cached
        if let cachedImage = ImageCache.manager.getCachedImage(withUrl: photo.url_m) {
            self.imageView.image = cachedImage
            self.setNeedsLayout()
        } else { //if image is not cached
            self.urlString = photo.url_m.absoluteString
            ImageCache.manager.processImageInBackground(imageURL: photo.url_m, completion: { (error, onlineImage) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let onlineImage = onlineImage {
                    if photo.url_m.absoluteString == self.urlString {
                        self.imageView.image = onlineImage
                        self.setNeedsLayout()
                    }
                }
            })
        }
        
    }

}
