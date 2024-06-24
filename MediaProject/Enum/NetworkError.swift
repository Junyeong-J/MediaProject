//
//  NetworkError.swift
//  MediaProject
//
//  Created by 전준영 on 6/25/24.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case custonError(message: String)
}
