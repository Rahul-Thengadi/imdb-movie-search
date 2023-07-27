//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation
import StorageProvider

struct MovieListViewModel {
    let movies: [Movie]
}

extension MovieListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return movies.count
    }
    
    func movieAtIndexPath(_ index: Int) -> MovieViewModel {
        let movie = movies[index]
        return MovieViewModel(movie: movie)
    }
}

struct MovieViewModel {
    let movie: Movie
}
