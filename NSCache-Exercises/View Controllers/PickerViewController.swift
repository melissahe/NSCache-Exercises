//
//  PickerViewController.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerCollectionView: UICollectionView!
    
    var cellSpacing: CGFloat = UIScreen.main.bounds.width * 0.03
    
    var photos: [Photo] = [] {
        didSet {
            pickerCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pickerCollectionView.delegate = self
        pickerCollectionView.dataSource = self
    }
    
    func loadPhoto(keyword: String) {
        FlickrAPI.manager.performSearch(keyword: keyword) { (error, photos) in
            if let error = error {
                print(error)
                return
            }
            
            if let photos = photos {
                self.photos = photos
            }
        }
    }

}

extension PickerViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        loadPhoto(keyword: searchText)
    }
}

extension PickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPhoto = photos[indexPath.row]
        let currentCell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
    
        PhotoDataModel.manager.addToFeed(photo: currentPhoto, andImage: currentCell.imageView.image)
    }
}

extension PickerViewController: UICollectionViewDelegateFlowLayout {
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

extension PickerViewController: UICollectionViewDataSource {
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
