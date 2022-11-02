//
//  MoviesViewController.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 24/10/22.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterBtn: UIButton!
    
    private var movies:[Movie] = []
    private var moviesNetwork = MoviesNetwork()
    let refreshControl = UIRefreshControl()
    var page:Int = 1
    var isPaging:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterBtn.layer.cornerRadius = self.filterBtn.frame.height/2
        self.filterBtn.clipsToBounds = true
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.collectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    
        moviesNetwork.getMovies("popular",1, completion: {
            result in
            self.movies = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
    }
    
    @IBAction func filterButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "FilterMoviesViewController") as! FilterMoviesViewController
        linkingVC.delegate = self
        
        
        if let presentationController = linkingVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(),.large()]
        }
        
        self.present(linkingVC, animated: true)
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        cell.layer.cornerRadius = 5
        cell.moviesLoading.startAnimating()
        cell.moviesTitleCV.text = self.movies[indexPath.row].title
        self.imageFromServerURL(NetworkService.baseUrlImage+self.movies[indexPath.row].backdropPath, completion:{
            result in
            DispatchQueue.main.async {
                cell.moviesImageCV?.image = result
                cell.moviesLoading.stopAnimating()
            }
        })
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-15, height: view.frame.size.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.movies.count - 1) {
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.page = self.page+1
                print("page number: \(self.page)")
                self.moviesNetwork.getMovies("popular",self.page, completion: {
                    result in
                    self.movies.append(contentsOf: result)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                })
            })
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.movies[indexPath.row].title)
    }
}

extension MoviesViewController: SearchFilterDelegate {
    func searchMovies(typeMovie: String) {
        self.dismiss(animated: true)
        self.moviesNetwork.getMovies(typeMovie,1, completion: {
            result in
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.movies = result
                self.collectionView.reloadData()
            })
        })
        print(typeMovie)
    }
}
