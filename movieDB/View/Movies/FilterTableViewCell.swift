//
//  FilterTableViewCell.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 01/11/22.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var filterRadioButton: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
