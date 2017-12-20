//
//  PhotoDataModel.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

//1 - create protocol with required methods
protocol PhotoDataModelDelegate: class {
    func didSelectItem(withPhoto photo: Photo, andImage image: UIImage?)
}

class PhotoDataModel {
    private init() {}
    static let manager = PhotoDataModel()
    //2. add delegate to model
    weak var delegate: PhotoDataModelDelegate?
    
    func addToFeed(photo: Photo, andImage image: UIImage?) {
        delegate?.didSelectItem(withPhoto: photo, andImage: image)
    }
}
