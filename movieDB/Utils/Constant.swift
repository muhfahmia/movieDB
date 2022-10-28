//
//  Constant.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 24/10/22.
//

import Foundation

struct Constant {
    let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
    let utilityQueue = DispatchQueue.global(qos: .utility)
    let backgroundQueue = DispatchQueue.global(qos: .background)
}
