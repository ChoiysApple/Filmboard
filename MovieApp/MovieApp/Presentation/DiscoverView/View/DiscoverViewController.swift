//
//  ViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class DiscoverViewController: UIViewController {
    
    let viewModel = DiscoverViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Discover"
        self.view.backgroundColor = UIColor(named: Colors.background)
        collectionView.delegate = self
        
        bindData()
        applyConstraint()
        
        viewModel.requestData()

    }
    
    //MARK: - Properties
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
    
    private func bindData() {
//        viewModel.movieFrontObservable
//            .bind(to: collectionView.rx.items(cellIdentifier: identifiers.discover_collection_cell, cellType: DiscoverCollectionViewCell.self)) { index, movie, cell in
//                cell.setData(movie: movie)
//            }
//            .disposed(by: disposeBag)
        
        viewModel.movieFrontObservable
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
    
    private func applyConstraint() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }


}

//MARK: - Collection View Configuration
extension DiscoverViewController {
    
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

