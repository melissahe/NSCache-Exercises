//
//  ViewController.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    var cellSpacing: CGFloat = UIScreen.main.bounds.width * 0.03
    
    var photos: [Photo] = [] {
        didSet {
            feedCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoDataModel.manager.delegate = self
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
    }

}

extension FeedViewController: PhotoDataModelDelegate {
    func didSelectItem(withPhoto photo: Photo, andImage image: UIImage?) {
        photos.append(photo)
    }
    
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells: CGFloat = 2
        let numberOfSpaces: CGFloat = numberOfCells + 1
        let width = (collectionView.bounds.width - (numberOfSpaces * cellSpacing)) / numberOfCells
        let height = collectionView.bounds.height - (cellSpacing * 2)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: 0, bottom: cellSpacing, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let currentPhoto = photos[indexPath.row]
        
        cell.imageView.image = nil
        cell.imageView.image = #imageLiteral(resourceName: "placeholder-image")
        
        cell.configureCell(withPhoto: currentPhoto)
        
        return cell
    }
    
    
}
