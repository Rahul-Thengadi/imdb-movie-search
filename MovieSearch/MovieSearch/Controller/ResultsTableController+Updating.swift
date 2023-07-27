//
//  ResultsTableController+Updating.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import UIKit
import StorageProvider

// MARK: UISearchResultsUpdating
extension ResultsTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let movies = Store.movies.map { Movie(title: $0.title, language: $0.language, year: $0.year, poster: $0.poster, genre: $0.genre, actors: $0.actors, directors: $0.director)}
        
        // Apply the filtered results to the search results table.
        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            searchController.searchResultsController?.view.isHidden = false
            guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
                loadMovies()
                resultsController.movieListVM = movieListVM
                resultsController.tableView.reloadData()
                return
            }
             
            searchQuery = searchText
            
            resultsController.movieListVM = MovieListViewModel(movies:  movies.filter { $0.title.lowercased().contains(searchQuery.lowercased()) ||
                $0.year.lowercased().contains(searchQuery.lowercased()) ||
                $0.genre!.lowercased().contains(searchQuery.lowercased()) ||
                $0.actors!.lowercased().contains(searchQuery.lowercased()) ||
                $0.directors!.lowercased().contains(searchQuery.lowercased())
            })
            resultsController.tableView.reloadData()
        }
    }
    
    private func loadMovies() {
        movieListVM = MovieListViewModel(movies: Store.movies.map { Movie(title: $0.title, language: $0.language, year: $0.year, poster: $0.poster, genre: $0.genre, actors: $0.actors, directors: $0.director) })
    }
}
