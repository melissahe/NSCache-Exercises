//
//  ImageCache.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageCache {
    private init() {}
    static let manager = ImageCache()
    private let sharedCached = NSCache<NSString, UIImage>()
    
    //store cached - process image and store in background
        //only used if you haven't stored image before
    func processImageInBackground(imageURL: URL, completion: @escaping (Error?, UIImage?) -> Void) {
        DispatchQueue.global().async {
            do {
                let imageData = try Data.init(contentsOf: imageURL)
                guard let image = UIImage.init(data: imageData) else {
                    return
                }
                //get image, then store it in cache
                self.sharedCached.setObject(image, forKey: imageURL.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(nil, image)
                }
                
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(error, nil)
                }
            }
        }
    }
    
    //get cached
    func getCachedImage(withUrl url: URL) -> UIImage? {
        return sharedCached.object(forKey: url.absoluteString as NSString)
    }
    
    
}
