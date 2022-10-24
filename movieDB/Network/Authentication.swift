//
//  Authentication.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation

class AuthenticationNetwork {
    func getAuth(_ username:String, _ password:String,_ token:String, completion: @escaping(Authentication) -> Void) {
        var components = URLComponents(string: NetworkService.baseUrl+NetworkService.pathCheckLogin)!
            components.queryItems = [
                URLQueryItem(name: "api_key", value: NetworkService.apiKey)
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["username":username,"password":password,"request_token":token])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    if response.statusCode == 200 {
                        let result = try decoder.decode(AuthResponseSuccess.self, from: data)
                        completion(self.authMappingSuccess(input: result))
                    }else{
                        let result = try decoder.decode(AuthResponseFail.self, from: data)
                        completion(self.authMappingFail(input: result))
                    }
                } catch let jsonError as NSError {
                  print("Error: Can't decode JSON. \(jsonError.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    fileprivate func authMappingFail(input authMapping:AuthResponseFail) -> Authentication {
        return Authentication(success: authMapping.success, statusMessage: authMapping.statusMessage)
    }
    fileprivate func authMappingSuccess(input authMapping:AuthResponseSuccess) -> Authentication {
        return Authentication(success: authMapping.success,statusMessage: "Login Successfully")
    }
}
