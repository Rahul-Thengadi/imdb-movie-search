//
//  Movie.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation

struct Movie {
    let title: String
    let language: String
    let year: String
    let poster: String
    let genre: String?
    let actors: String?
    let directors: String?
    
    init(title: String, language: String, year: String, poster: String, genre: String? = nil, actors: String? = nil, directors: String? = nil) {
        self.title = title
        self.language = language
        self.year = year
        self.poster = poster
        self.genre = genre
        self.actors = actors
        self.directors = directors
    }
}
