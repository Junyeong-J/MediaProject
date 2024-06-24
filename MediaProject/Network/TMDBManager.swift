//
//  TMDBManager.swift
//  MediaProject
//
//  Created by 전준영 on 6/25/24.
//

import Foundation
import Alamofire

class TMDBManager {
    
    static let shared = TMDBManager()
    private init() {}
    
    func getTMDBSimilar(id: Int, completionHandler: @escaping (Result<SimilarResponse, NetworkError>) -> Void) {
        let url = "\(APIURL.TMDBMovieSimilarURL1)\(id)\(APIURL.TMDBMovieSimilarURL2)"
        let params = [
            "language" : "ko"
        ]
        
        let headers: HTTPHeaders = ["AUTHORIZATION" : APIKey.TMDBAuthorization]
        AF.request(url, parameters: params, headers: headers).responseDecodable(of: SimilarResponse.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(.success(value))
            case .failure(_):
                completionHandler(.failure(.networkError))
            }
        }
    }
    
    func getTMDBRecommend(id: Int, completionHandler: @escaping (Result<RecommendResponse, NetworkError>) -> Void) {
        let url = "\(APIURL.TMDBMovieSimilarURL1)\(id)\(APIURL.TMDBMovieRecommendURL)"
        let params = [
            "language" : "ko"
        ]
        
        let headers: HTTPHeaders = ["AUTHORIZATION" : APIKey.TMDBAuthorization]
        AF.request(url, parameters: params, headers: headers).responseDecodable(of: RecommendResponse.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(.success(value))
            case .failure(_):
                completionHandler(.failure(.networkError))
            }
        }
    }
    
}
