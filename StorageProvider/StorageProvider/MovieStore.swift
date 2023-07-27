//
//  Movie.swift
//  StorageProvider
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation

public struct Store {
    public static var movies: [Movie] = {
        guard let bundle = Bundle(identifier: "com.rahulthengadi.StorageProvider"),
              let fileURL = bundle.url(forResource: "movies", withExtension: "json") else {
            fatalError("couldn't locate the file")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            fatalError("couldn't load the content of data")
        }
    }()
}


public struct Movie: Codable {
    public let title, year, rated, released: String
    public let runtime, genre, director, writer: String
    public let actors, plot, language, country: String
    public let awards: String
    public let poster: String
    public let ratings: [Rating]
    public let metascore, imdbRating, imdbVotes, imdbID: String
    public let type: TypeEnum
    public let dvd: DVD?
    public let boxOffice, production: String?
    public let website: DVD?
    public let response: Response

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

public enum DVD: String, Codable {
    case nA = "N/A"
    case the28Nov2000 = "28 Nov 2000"
    case the30Jan2007 = "30 Jan 2007"
}

// MARK: - Rating
public struct Rating: Codable {
    public let source: Source
    public let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

public enum Source: String, Codable {
    case internetMovieDatabase = "Internet Movie Database"
    case metacritic = "Metacritic"
    case rottenTomatoes = "Rotten Tomatoes"
}

public enum Response: String, Codable {
    case responseTrue = "True"
}

public enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}
