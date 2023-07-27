//
//  ResultsTableController.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import UIKit
import StorageProvider

protocol ResultControllerDidTapGesture: AnyObject {
    func didTapResultControllerView()
}

class ResultsTableController: UITableViewController {
    // MARK: Properties
    let tableViewCellIdentifier = "movieCell"
    var filteredProducts = [Movie]()
    var searchQuery = ""
    
    weak var resultControllerDelegate: ResultControllerDidTapGesture?
    
    var movieListVM: MovieListViewModel!
    var movieDetailController: MovieDetailController!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadMovies()
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(handleKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Helpers
    // TODO: could move in to adapter class
    private func loadMovies() {
        movieListVM = MovieListViewModel(movies: Store.movies.map { Movie(title: $0.title, language: $0.language, year: $0.year, poster: $0.poster, genre: $0.genre, actors: $0.actors, directors: $0.director) })
    }
    
    @objc private func handleKeyboard() {
        resultControllerDelegate?.didTapResultControllerView()
    }
}

// MARK: ResultsTableControllerDataSource
extension ResultsTableController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return movieListVM == nil ? 0 : movieListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! MovieCell
        let movieVM = movieListVM.movieAtIndexPath(indexPath.row)
        cell.configureCell(movieVM, index: indexPath)
        return cell
    }
}

// MARK: UITableViewDelegate
extension ResultsTableController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieListVM.movies[indexPath.row]
        movieDetailController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailController") as? MovieDetailController
        let storedMovie = Store.movies.filter { $0.title == movie.title && $0.year == movie.year}
        guard let storedMovie = storedMovie.first else { return }
        movieDetailController.movieDetail = MovieDetailViewModel(title: storedMovie.title, plot: storedMovie.plot, cast: storedMovie.actors, release: storedMovie.released, genre: storedMovie.genre, rating: storedMovie.ratings.map { $0.value } , posterImageURL: storedMovie.poster)
         resultControllerDelegate?.didTapResultControllerView()
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
}

// MARK: MovieCell
extension MovieCell {
    func configureCell(_ viewModel: MovieViewModel, index: IndexPath) {
        titleLabel.text = "Movie: \(viewModel.movie.title)"
        languageLabel.text = "Language: \(viewModel.movie.language)"
        yearLabel.text = "Released: \(viewModel.movie.year)"
        setupPosterImage(with: viewModel)
    }
}

