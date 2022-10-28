//
//  Session.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 24/10/22.
//

import Foundation

class SessionNetwork {
    func getSessionAuth(completion: @escaping(Session) -> Void) {
        var components = URLComponents(string: NetworkService.baseUrl+NetworkService.pathSessionLogin)!
            components.queryItems = [
                URLQueryItem(name: "api_key", value: NetworkService.apiKey)
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["request_token":User.token])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    if response.statusCode == 200 {
                        let result = try decoder.decode(SessionAuthResponseSuccess.self, from: data)
                        completion(self.sessionMappingSucccess(input: result))
                    }else{
                        let result = try decoder.decode(SessionAuthResponseFail.self, from: data)
                        completion(self.sessionMappingFail(input: result))
                    }
                } catch let jsonError as NSError {
                  print("Error: Can't decode JSON. \(jsonError.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    fileprivate func sessionMappingSucccess(input session:SessionAuthResponseSuccess) -> Session {
        return Session(success: session.success, statusMessage: "Access Permission")
    }
    
    fileprivate func sessionMappingFail(input session:SessionAuthResponseFail) -> Session {
        return Session(success: session.success, statusMessage: session.statusMessage)
    }
}
