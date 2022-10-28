//
//  Movie.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation
class Movie {
    let movieId: Int
    let title: String
    let releaseDate: String
    let backdropPath: String
    
    init(movieId: Int, title: String, releaseDate: String, backdropPath: String) {
        self.movieId = movieId
        self.title = title
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
    }
}

struct MovieResponse:Codable {
    let page:Int
    let movie:[MovieObject]
    
    enum CodingKeys:String, CodingKey {
        case page
        case movie = "results"
    }
}

struct MovieObject:Codable {
    let movieId:Int
    let title:String
    let releaseDate:String
    let backdropPath:String
    
    enum CodingKeys:String, CodingKey {
        case movieId = "id"
        case title
        case releaseDate = "release_date"
        case backdropPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieId = try container.decode(Int.self, forKey: .movieId)
        self.title = try container.decode(String.self, forKey: .title)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
    }
    
}
