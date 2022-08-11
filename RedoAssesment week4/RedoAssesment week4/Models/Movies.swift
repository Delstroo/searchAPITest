//
//  Movies.swift
//  RedoAssesment week4
//
//  Created by Delstun McCray on 8/6/21.
//

import Foundation

struct TopLevelObject: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let originalTitle: String
    let overview: String
    let postPath: String?
    let releaseDate: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case postPath = "poster_path"
        case releaseDate = "release_date"
        case overview = "overview"
        case voteAverage = "vote_average"
    }
}//end of struct
