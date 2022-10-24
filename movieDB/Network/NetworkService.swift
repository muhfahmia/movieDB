//
//  NetworkService.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation

struct NetworkService {
    static let apiKey = "fbb7a74bee5c071d2aaf776704e2b328"
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    static let pathRequestToken = "authentication/token/new"
    static let pathCheckLogin = "authentication/token/validate_with_login"
}
