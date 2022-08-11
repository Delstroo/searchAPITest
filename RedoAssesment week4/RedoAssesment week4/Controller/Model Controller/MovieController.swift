//
//  MovieController.swift
//  RedoAssesment week4
//
//  Created by Delstun McCray on 8/6/21.
//

import Foundation
import UIKit

class MovieController {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static var baseURL = "https://api.themoviedb.org/3/search/movie"
    
//https://api.themoviedb.org/3/search/movie?api_key=e8369f0c787da6ec0da2dd3a8efd0c3c&query=\(searchterm)
    
    static func fetchMovie(searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
  
        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidURL))}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiQuerey = URLQueryItem(name: "api_key", value: "e8369f0c787da6ec0da2dd3a8efd0c3c")
        let searchQuerey = URLQueryItem(name: "query", value: searchTerm)
        components?.queryItems = [apiQuerey, searchQuerey]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.throwError(error)))
                
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("STATUS CODE: \(response.statusCode)")
                    
                }
                
                guard let data = data else { return completion(.failure(.noData))}
                
                do {
                    let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                    

                    var arrayOfMovies: [Movie] = []
                    for movie in topLevelObject.results {
                        arrayOfMovies.append(movie)
                    }
                    completion(.success(arrayOfMovies))
                } catch {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    return completion(.failure(.throwError(error)))
                }
            }
        }.resume()
    }
    
    static func fetchPoster(secondaryURL: String ,posterURL: String, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500") else { return completion(.failure(.invalidURL)) }
 
        let finalURL = baseURL.appendingPathComponent(posterURL)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _ , error in
            
            if let error = error {
                return completion(.failure(.throwError(error)))
                
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let poster = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            self.cache.setObject(poster, forKey: NSString(string: posterURL))
            completion(.success(poster))
            
        }.resume()
    }
}//end of class
