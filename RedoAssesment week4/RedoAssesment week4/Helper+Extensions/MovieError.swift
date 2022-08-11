//
//  MovieError.swift
//  RedoAssesment week4
//
//  Created by Delstun McCray on 8/6/21.
//

import Foundation

enum MovieError: LocalizedError {
    
    case invalidURL
    case throwError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "There was a failure with the server."
        case .throwError(_):
            return "there was an error with our network call."
        case .noData:
            return "There was no data found."
        case .unableToDecode:
            return "there was no data found."
        }
    }
}//end of enum

