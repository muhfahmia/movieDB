//
//  RequestTokenModel.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation
class RequestToken {
    let success:Bool
    let expiredAt:String
    let requestToken:String
    
    init(success: Bool, expiredAt: String, requestToken: String) {
        self.success = success
        self.expiredAt = expiredAt
        self.requestToken = requestToken
    }
}

struct RequestTokenResponses: Codable {
    let success: Bool
    let expiredAt: String
    let requestToken: String
    
    enum CodingKeys:String, CodingKey {
        case success
        case expiredAt = "expires_at"
        case requestToken = "request_token"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        success = try container.decode(Bool.self, forKey: .success)
        expiredAt = try container.decode(String.self, forKey: .expiredAt)
        requestToken = try container.decode(String.self, forKey: .requestToken)
    }
    
}
