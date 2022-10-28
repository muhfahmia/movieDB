//
//  NetworkService.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation
import UIKit

struct NetworkService {
    static let apiKey = "fbb7a74bee5c071d2aaf776704e2b328"
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let baseUrlImage = "https://image.tmdb.org/t/p/original/"
    
    static let pathRequestToken = "authentication/token/new"
    static let pathCheckLogin = "authentication/token/validate_with_login"
    static let pathSessionLogin = "authentication/session/new"
    static let pathPopularMovies = "movie/popular"
    static let pathTopRatingMovies = "movie/top_rated"
    static let pathUpComing = "movie/upcoming"
    static let pathNowPlaying = "movie/now_playing"
}
