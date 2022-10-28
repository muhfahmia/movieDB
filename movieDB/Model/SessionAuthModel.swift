//
//  SessionAuthModel.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 22/10/22.
//

import Foundation

class Session {
    let success: Bool
    let statusMessage: String
    init(success: Bool, statusMessage: String) {
        self.success = success
        self.statusMessage = statusMessage
    }
}

struct SessionAuthResponseSuccess: Codable {
    let success: Bool
    enum CodingKeys:String, CodingKey {
        case success
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
    }
}


struct SessionAuthResponseFail: Codable {
    let success: Bool
    let statusMessage: String
    enum CodingKeys:String, CodingKey {
        case success
        case statusMessage = "status_message"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
    }
}
