//
//  Search.swift
//  NSCache-Exercises
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Search: Codable {
    let photos: Results
}

struct Results: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo] //array of photos from json data
}

struct Photo: Codable {
    let id: String
    let title: String
    let url_m: URL //image url
}
