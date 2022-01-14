//
//  ViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/03.
//

import UIKit
import SnapKit

class DiscoverViewController: UIViewController {
    
    // Sample Data
    let movies = [
        MovieFront(title: "Spider-Man: No Way Home", posterPath: "1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", genre: "Genre", releaseDate: "2021-12-15", ratingScore: 8.4, ratingCount: 3955),
        MovieFront(title: "Spider-Man: No Way Home", posterPath: "1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", genre: "Genre", releaseDate: "2021-12-15", ratingScore: 7, ratingCount: 3955),
        MovieFront(title: "The Matrix Resurrections", posterPath: "/gZlZLxJMfnSeS60abFZMh1IvODQ.jpg", genre: "Genre", releaseDate: "2021-12-16", ratingScore: 7, ratingCount: 2056)
    ]
    
    lazy var collectionView = { () -> UICollectionView in
        
        // FlowLayout
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: self.preferredContentSize.width, height: 180)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20

        // Collection View
        var collectionView =  UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: identifiers.discover_collection_cell)
        collectionView.register(DiscoverCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifiers.discover_collection_header)
        collectionView.backgroundColor = UIColor(named: Colors.background)
        
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Discover"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.view.backgroundColor = UIColor(named: Colors.background)
    
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
        
    }


}

//MARK: - Collection View Configuration
//TODO: Will be deleted when RxCocoa added
extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = movies[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return DiscoverCollectionViewCell() }
        cell.setData(movie: movie)
        
        return cell
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: identifiers.discover_collection_header,
              for: indexPath)
    }
    
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! DiscoverCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.size.width - 60)/2
        
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
    

    
}

