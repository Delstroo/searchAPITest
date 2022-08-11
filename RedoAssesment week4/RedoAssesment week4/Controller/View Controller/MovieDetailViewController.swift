//
//  MovieDetailViewController.swift
//  RedoAssesment week4
//
//  Created by Delstun McCray on 8/6/21.
//

import UIKit


class MovieDetailViewController: UIViewController {

    var movie: Movie?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var backgroundPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        
        let underlineAttriString = NSAttributedString(string: movie.originalTitle,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            nameLabel.attributedText = underlineAttriString
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        ratingLabel.text = "\(movie.voteAverage)"
        
        MovieController.fetchPoster(secondaryURL:"https://image.tmdb.org/t/p/w500", posterURL: movie.postPath ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let postPath):
                    self.posterImageView.image = postPath
                    self.backgroundPhoto.image = postPath
                case .failure(_):
                    self.posterImageView.image = UIImage(named: "placeholder")
                    self.backgroundPhoto.image = UIImage(named: "placeholder")
                
                    
                }
            }
        }
    }//end of func
}//end of class
