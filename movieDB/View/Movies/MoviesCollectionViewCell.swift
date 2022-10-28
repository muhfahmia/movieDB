//
//  MoviesCollectionViewCell.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 25/10/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviesImageCV: UIImageView!
    
    @IBOutlet weak var moviesLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var moviesTitleCV: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 0.3
        // Initialization code
    }

}
