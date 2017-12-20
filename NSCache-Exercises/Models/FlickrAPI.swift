//
//  FlickerApi.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class FlickrAPI {
    private init() {}
    static let manager = FlickrAPI()
    private let session = URLSession(configuration: .default)
    func performSearch(keyword: String, completion: @escaping (Error?, [Photo]?) -> Void) {
        guard let formattedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=5c4d63a29e4f34c05e7d8759789fe197&lat=40.93&lon=-73.88&format=json&extras=url_m, description&per_page=200&text=\(formattedKeyword)&nojsoncallback=1&safe_search=3".replacingOccurrences(of: " ", with: "")
        
        guard let url = URL(string: searchURL) else {
            print("bad url: \(searchURL)")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Error: \(response.statusCode)")
                }
            }
            
            if let data = data {
                //json parsing to create your model objects
                do {
                   let search = try JSONDecoder().decode(Search.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(nil, search.photos.photo)
                    }
                } catch let error {
                    print(error)
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                }
            }
        }.resume()
    }
}
