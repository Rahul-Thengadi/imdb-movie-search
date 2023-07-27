//
//  DetailTableController.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import UIKit
import StorageProvider

class DetailTableController: UITableViewController {

    // MARK: Properties
    let tableViewCellIdentifier = "detailCell"
    
    var detailListVM: DetailListViewModel!
    var movieTableController:  ResultsTableController!
    var movieListViewModel: MovieListViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovies()
    }
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    // MARK: Helpers
    private func loadMovies() {
        movieTableController = storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        movieListViewModel = MovieListViewModel(movies: Store.movies.map { Movie(title: $0.title, language: $0.language, year: $0.year, poster: $0.poster, genre: $0.genre, actors: $0.actors, directors: $0.director) })
        movieTableController.movieListVM = movieListViewModel
    }
}

// MARK: DetailTableControllerDataSource

extension DetailTableController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailListVM == nil ? 0 : detailListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let detailVM = detailListVM.detailAtIndexPath(indexPath.row)
        cell.textLabel?.text = detailVM.detail.value
        return cell
    }
}

// MARK: DetailTableControllerDelegate
extension DetailTableController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVM = detailListVM.details[indexPath.row]
        navigate(with: detailVM)
    }
    
    private func navigate(with detailModel: Detail) {
        switch Category.currentCategory {
        case .year:
            movieTableController.movieListVM = MovieListViewModel(movies: movieTableController.movieListVM.movies.filter { $0.year == detailModel.value } )
            movieTableController.title = "Movies in year \(detailModel.value)"
            movieTableController.tableView.reloadData()
            navigationController?.pushViewController(movieTableController, animated: true)
        case .genre:
            movieTableController.movieListVM = MovieListViewModel(movies: movieTableController.movieListVM.movies.filter { String($0.genre!).contains(detailModel.value) })
            movieTableController.title = "Movies by \(detailModel.value)"
            movieTableController.tableView.reloadData()
            navigationController?.pushViewController(movieTableController, animated: true)
            
        case .directors:
            movieTableController.movieListVM = MovieListViewModel(movies: movieTableController.movieListVM.movies.filter { $0.directors!.contains(detailModel.value) })
            movieTableController.title = "Movies by \(detailModel.value)"
            movieTableController.tableView.reloadData()
            navigationController?.pushViewController(movieTableController, animated: true)
            
        case .actors:
            movieTableController.title = "Movies by \(detailModel.value)"
            movieTableController.movieListVM = MovieListViewModel(movies: movieTableController.movieListVM.movies.filter { $0.actors!.contains(detailModel.value) })
            movieTableController.tableView.reloadData()
            navigationController?.pushViewController(movieTableController, animated: true)
        }
    }
}

