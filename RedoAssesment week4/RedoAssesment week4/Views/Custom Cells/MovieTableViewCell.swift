//
//  MovieTableViewCell.swift
//  RedoAssesment week4
//
//  Created by Delstun McCray on 8/6/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        
        movieNameLabel.text = movie.originalTitle
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        
        MovieController.fetchPoster(secondaryURL:"https://image.tmdb.org/t/p/w500", posterURL: movie.postPath ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let postPath):
                    self.posterImageView.image = postPath
                case .failure(_):
                    self.posterImageView.image = UIImage(named: "placeholder")
                    
                }
            }
        }
    }//end of func
}//end of class
