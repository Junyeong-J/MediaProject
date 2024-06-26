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
    
    var changeDate: String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let changeFormat = DateFormatter()
        changeFormat.dateFormat = "MM/dd/yyyy"
        if let date = dateFormat.date(from: releaseDate) {
            return changeFormat.string(from: date)
        } else {
            return nil
        }
    }
}


struct TMDBDetailResponse: Decodable {
    let id: Int
    let cast: [CastMember]
}

struct CastMember: Decodable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int
    let character: String
    let creditID: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, character, order
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case creditID = "credit_id"
    }
}

struct SimilarResponse: Decodable {
    let page: Int
    let results: [TMDBMovie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TMDBMovie: Decodable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}

struct RecommendResponse: Decodable {
    let page: Int
    let results: [TMDBMovieData]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TMDBMovieData: Decodable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}

struct TMDBMovieVideo: Decodable {
    let id: Int
    let results: [VideoData]
}

struct VideoData: Decodable {
    let key: String
}
