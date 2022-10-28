//
//  Movies.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 25/10/22.
//

import Foundation

class MoviesNetwork {
    func getMovies(_ type:String ,completion: @escaping ([Movie]) -> Void) {
        
        var typeMovies = ""
        switch typeMovies {
        case "popular":
            typeMovies = NetworkService.pathPopularMovies
        case "topRating":
            typeMovies = NetworkService.pathTopRatingMovies
        case "nowPlaying":
            typeMovies = NetworkService.pathNowPlaying
        case "upComing":
            typeMovies = NetworkService.pathUpComing
        default:
            typeMovies = NetworkService.pathPopularMovies
        }
        
        var components = URLComponents(string: NetworkService.baseUrl+typeMovies)!
            components.queryItems = [
                URLQueryItem(name: "api_key", value: NetworkService.apiKey)
            ]
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    if response.statusCode == 200 {
                        let result = try decoder.decode(MovieResponse.self, from: data)
                        completion(self.moviesMapping(input: result.movie))
                    }else{
                        print("Error: Can't HIT API: \(String(describing: error?.localizedDescription))")
                    }
                } catch let jsonError as NSError {
                  print("Error: Can't decode JSON. \(jsonError.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    fileprivate func moviesMapping(input movies:[MovieObject]) -> [Movie] {
        return movies.map {
            movie in
            return Movie(
                movieId: movie.movieId,
                title: movie.title,
                releaseDate: movie.releaseDate,
                backdropPath: movie.backdropPath
            )
        }
    }
}
