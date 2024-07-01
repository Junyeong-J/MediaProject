//
//  Movie.swift
//  MediaProject
//
//  Created by 전준영 on 6/11/24.
//

import Foundation

struct Movie: Decodable {
    
    let page: Int
    var results: [MovieData]
    let total_pages: Int
    let total_results: Int
}

struct MovieData: Decodable {
    let poster_path: String?
}
