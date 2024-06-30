//
//  TMDBRequest.swift
//  MediaProject
//
//  Created by 전준영 on 6/30/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    
    case similarMovie(id: Int)
    case recommendMovie(id: Int)
    case moviePoster(id: Int)
    
    var baseURL: String {
        return APIURL.TMDBBaseURL
    }
    
    var endpoint: URL {
        switch self {
        case .similarMovie(id: let id):
            return URL(string: baseURL + "\(id)\(APIURL.TMDBMovieSimilarEndPoint)")!
        case .recommendMovie(let id):
            return URL(string: baseURL + "\(id)\(APIURL.TMDBMovieRecommendEndPoint)")!
        case .moviePoster(let id):
            return URL(string: baseURL + "\(id)\(APIURL.TMDBMoviePosterEndPoint)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["AUTHORIZATION" : APIKey.TMDBAuthorization]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .similarMovie, .recommendMovie, .moviePoster:
            return ["language": "ko-KR"]
        }
    }
}
