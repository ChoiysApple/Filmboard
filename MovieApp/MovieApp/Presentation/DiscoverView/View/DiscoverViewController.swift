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
    
    lazy var headerView = DiscoverCollectionHeaderView()
    
    lazy var collectionView = { () -> UICollectionView in
        
        // FlowLayout
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20

        // Collection View
        var collectionView =  UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.discover_collection_cell)
        collectionView.backgroundColor = UIColor(named: UIColor.background)
        
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
        self.view.backgroundColor = UIColor(named: UIColor.background)
        self.dismissKeyboard()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let customRefreshControl = UIRefreshControl().then {  $0.tintColor = .white }
        collectionView.refreshControl = customRefreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setUpLayout() {
        
        [headerView, collectionView].forEach { self.view.addSubview($0) }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(180)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func bindData() {
        viewModel.movieListData
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        headerView.searchFieldCallBack = { [weak self] keyword in
            self?.viewModel.requestData(keyword: keyword, page: 1)
        }
    }

}

extension DiscoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieListData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(movie: viewModel.movieListData.value[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.frame.size.width - 60)/2
        
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.viewModel.movieListData.value[indexPath.row].id
        self.navigationController?.pushViewController(DetailViewController(id: id), animated: true)
    }
}

// MARK: Dismiss Keyaord
extension DiscoverViewController {
    func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DiscoverViewController.dismissKeyboardTouchOutside))
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
