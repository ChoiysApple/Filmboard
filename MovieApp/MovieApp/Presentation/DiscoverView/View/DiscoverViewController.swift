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
    
    let viewModel = DiscoverViewModel.shared
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Discover"
        self.view.backgroundColor = UIColor(named: Colors.background)
        self.dismissKeyboard()
        collectionView.delegate = self
        
        let customRefreshControl = UIRefreshControl().then{  $0.tintColor = .white }
        collectionView.refreshControl = customRefreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        bindData()
        applyConstraint()
        
        viewModel.requestData(page: 1)
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
        viewModel.movieFrontObservable
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
    
    private func applyConstraint() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }


}

//MARK: UICollectionViewDelegateFlowLayout
extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.size.width - 60)/2
        
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
}

extension DiscoverViewController {
    
    //MARK: Cell Selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DiscoverCollectionViewCell else { return }
        guard let id = cell.contentId else { return }
        
        self.navigationController?.pushViewController(DetailViewController(id: id), animated: true)
    }
}

//MARK: Dismiss Keyaord
extension DiscoverViewController {
    func dismissKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(DiscoverViewController.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
        @objc private func dismissKeyboardTouchOutside() {
           view.endEditing(true)
        }
}

extension DiscoverViewController {
    @objc private func refreshData() {
        
        self.viewModel.requestData(page: 1)
        self.collectionView.refreshControl?.endRefreshing()
        
    }
}
