//
//  TMDB.swift
//  Movie
//
//  Created by 전준영 on 6/10/24.
//

import Foundation

struct TMDBResponse: Decodable {
    let page: Int
    let results: [TMDBResult]
}

struct TMDBResult: Decodable {
    let backdropPath: String
    let id: Int
    let originalTitle, overview, posterPath: String
    let adult: Bool
    let title: String?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case adult
        case title
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
