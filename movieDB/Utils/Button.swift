//
//  Button.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 19/10/22.
//

import Foundation
import UIKit

@IBDesignable
class primaryButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius =  15
        }
    }
}
