//
//  ViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/03.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class DiscoverViewController: UIViewController {
    
    private let viewModel = DiscoverViewModel()
    private let disposeBag = DisposeBag()
    
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
        
        setUpView()
        setUpLayout()
        bindData()
        
        viewModel.requestData(page: 1)
    }
    
    private func setUpView() {
        self.title = "Discover"
        self.view.backgroundColor = UIColor(named: Colors.background)
        self.dismissKeyboard()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let customRefreshControl = UIRefreshControl().then{  $0.tintColor = .white }
        collectionView.refreshControl = customRefreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setUpLayout() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
    
    private func bindData() {
        viewModel.movieListData
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }

}

extension DiscoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieListData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(movie: viewModel.movieListData.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifiers.discover_collection_header, for: indexPath) as? DiscoverCollectionHeaderView else {
                return UICollectionReusableView()
            }
            header.searchFieldCallBack = { [weak self] keyword in
                self?.viewModel.requestData(keyword: keyword, page: 1)
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.size.width - 60)/2
        
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DiscoverCollectionViewCell else { return }
        guard let id = cell.contentId else { return }
        
        self.navigationController?.pushViewController(DetailViewController(id: id), animated: true)
    }
}

// MARK: Dismiss Keyaord
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

// MARK: Refresh Control
extension DiscoverViewController {
    @objc private func refreshData() {
        
        self.viewModel.requestData(page: 1)
        self.collectionView.refreshControl?.endRefreshing()
        
    }
}
