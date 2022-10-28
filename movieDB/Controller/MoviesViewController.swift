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
    
    private var movies:[Movie] = []
    private var moviesNetwork = MoviesNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        print("lebar: \(view.frame.size.width)")
        print("tinggi: \(view.frame.size.height)")
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.collectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    
        moviesNetwork.getMovies("popular", completion: {
            result in
            self.movies = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
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
        self.imageFromServerURL(NetworkService.baseUrlImage+self.movies[indexPath.row].backdropPath, completion:{
            result in cell.moviesImageCV.image = result
            cell.moviesLoading.stopAnimating()
        })
        cell.moviesTitleCV.text = self.movies[indexPath.row].title
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
    
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.movies[indexPath.row].title)
    }
}
