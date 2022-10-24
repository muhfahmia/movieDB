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
    
    init(movieId: Int, title: String, releaseDate: String) {
        self.movieId = movieId
        self.title = title
        self.releaseDate = releaseDate
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
    let movieId:String
    let title:String
    let releaseDate:String
    
    enum CodingKeys:String, CodingKey {
        case movieId = "id"
        case title
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieId = try container.decode(String.self, forKey: .movieId)
        self.title = try container.decode(String.self, forKey: .title)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
    
}
