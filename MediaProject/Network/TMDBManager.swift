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
    
    func trendingFetch<T: Decodable>(api: TMDBRequest, model: T.Type, completionHandler: @escaping (T?, TMDBError?) -> Void) {
        AF.request(api.endpoint, method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let value):
                print("success")
                print(value)
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, .failedRequest)
                print(error)
            }
        }
    }
    
}
