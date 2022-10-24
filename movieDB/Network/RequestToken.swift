//
//  RequestToken.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation

class RequestTokenNetwork {
    func getToken() async throws -> RequestToken {
        var components = URLComponents(string: NetworkService.baseUrl+NetworkService.pathRequestToken)!
            components.queryItems = [
                URLQueryItem(name: "api_key", value: NetworkService.apiKey)
            ]
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
         
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
          fatalError("Error: Can't fetching data.")
        }
        let decoder = JSONDecoder()
        let result = try decoder.decode(RequestTokenResponses.self, from: data)
        return tokenMapping(input: result)
    }

    fileprivate func tokenMapping(input tokenResponse:RequestTokenResponses) -> RequestToken {
        return RequestToken(success: tokenResponse.success, expiredAt: tokenResponse.expiredAt, requestToken: tokenResponse.requestToken)
    }
}
