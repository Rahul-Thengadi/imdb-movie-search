//
//  Category.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation

enum Category: String, CaseIterable {
    case year = "year"
    case genre = "genre"
    case directors = "directors"
    case actors = "actors"
    
    static var currentCategory: Category = .year
}

