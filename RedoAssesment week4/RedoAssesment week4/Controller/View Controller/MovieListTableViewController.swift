//
//  MovieListTableViewController.swift
//  RedoAssesment week4
//
//  Created by Delstun McCray on 8/6/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //Landing pad
    var movie: [Movie?] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }//end of func
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }//end of fun
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = self.movie[indexPath.row]
        
        cell.movie = movie
        
        return cell
    }//end of func
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }//end of func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MovieDetailViewController else { return }
            
            let selectedMovie = movie[indexPath.row]
            destination.movie = selectedMovie
        }
    }
}//end of class

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        MovieController.fetchMovie(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movie = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }//end of func
}//end of extension
