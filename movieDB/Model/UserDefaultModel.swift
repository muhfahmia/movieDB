//
//  UserModel.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation

struct User {
    static let isLoginKey = "state"
    static let usernameKey = "username"
    static let tokenKey = "token"
    static let expiredAtKey = "2022-10-21 12:12:12"
    
    static var stateLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isLoginKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isLoginKey)
        }
    }
    
    static var username: String {
        get {
            return UserDefaults.standard.string(forKey: usernameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameKey)
        }
    }
    
    static var token: String {
        get {
            return UserDefaults.standard.string(forKey: tokenKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
    
    static var expiredAt: String {
        get {
            return UserDefaults.standard.string(forKey: expiredAtKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: expiredAtKey)
        }
    }
}
