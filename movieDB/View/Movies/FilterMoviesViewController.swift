//
//  FilterMoviesViewController.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 01/11/22.
//

import UIKit

protocol SearchFilterDelegate {
    func searchMovies(typeMovie:String)
}

class FilterMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var delegate:SearchFilterDelegate?
    
    @IBOutlet weak var optionFilterSV: UIStackView!
    
    @IBOutlet weak var filterTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var filterTableView: UITableView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var activeFilterValueIndex = 0
    
    var getTypeFilter = ["popular","topRating","upComing","nowPlaying"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterTableView.dataSource = self
        self.filterTableView.delegate = self
        self.filterTableView.separatorStyle = .none
        self.filterTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        
        self.searchButton.layer.cornerRadius = 5
        
    }
    
    override func viewWillLayoutSubviews() {
        self.filterTableViewHeight.constant = self.filterTableView.contentSize.height
    }
    
    @IBAction func filterSearch(_ sender: Any) {
        delegate?.searchMovies(typeMovie: self.getTypeFilter[activeFilterValueIndex])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return getTypeFilter.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = UILabel()
        header.tintColor = .black
        header.textColor = .black
        header.text = "Filters"
        header.font = UIFont.boldSystemFont(ofSize: 24.0)
        return header.text
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell",for: indexPath) as? FilterTableViewCell {
            cell.selectionStyle = .none
            cell.filterLabel.text = getTypeFilter[indexPath.row]
            if indexPath.row == 0 {
                cell.filterRadioButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            }
          return cell
        } else {
          return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let typeFilter = self.getTypeFilter[indexPath.row]
//        var type = "popular"
//        switch typeFilter {
//        case "Popular":
//            type = "popular"
//        case "Upcoming":
//            type = "upComing"
//        case "Now Playing":
//            type = "nowPlaying"
//        case "Top Rating":
//            type = "topRating"
//        default:
//            type = "popular"
//        }
        
        let cell = self.filterTableView.cellForRow(at: indexPath) as! FilterTableViewCell
        let cellActive = self.filterTableView.cellForRow(at: IndexPath(row: self.activeFilterValueIndex, section: 0)) as! FilterTableViewCell
        
        cellActive.filterRadioButton.setImage(UIImage(systemName: "circle"), for: .normal)
        cell.filterRadioButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        self.activeFilterValueIndex = indexPath.row
    }
    
}
