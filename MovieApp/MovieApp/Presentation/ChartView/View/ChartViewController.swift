//
//  ChartViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: UIColor.background)
        $0.allowsSelection = true
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: Identifiers.chart_table_cell)
        
        let spinner = UIActivityIndicatorView(style: .medium)
        $0.tableFooterView = spinner
        $0.tableFooterView?.isHidden = true
    }
    
    lazy var navigationAppearance = UINavigationBarAppearance().then {
        $0.titleTextAttributes = [.foregroundColor: UIColor.white]
        $0.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        $0.backgroundColor = UIColor(named: UIColor.background)
    }
    
    // MARK: - Instances
    private let viewModel = ChartViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Charts"

        setUpView()
        setUpLayout()
        bindData()

        viewModel.requestData(category: .popular)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setUpView() {
        
        self.view.backgroundColor = UIColor(named: UIColor.background)
        self.view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let customRefreshControl = UIRefreshControl().then {  $0.tintColor = .white }
        tableView.refreshControl = customRefreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // Navigation
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        // Category Menu
        let categoryMenuItem = [
            UIAction(title: "Popular", image: UIImage(systemName: "flame.fill"), handler: { _ in self.viewModel.requestData(category: .popular) }),
            UIAction(title: "Top Rated", image: UIImage(systemName: "star.fill"), handler: { _ in self.viewModel.requestData(category: .topRated) }),
            UIAction(title: "Now Playing", image: UIImage(systemName: "theatermasks.fill"), handler: { _ in self.viewModel.requestData(category: .nowPlaying) })
        ]
        let categoryMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: categoryMenuItem)
        
        // NavigationBarItem
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), primaryAction: nil, menu: categoryMenu)
        categoryButton.tintColor = .white
        navigationItem.rightBarButtonItem = categoryButton
        
    }
    
    private func setUpLayout() {
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
    
    // MARK: Data Binding
    private func bindData() {
        viewModel.movieListData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.listTitle
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { self.navigationItem.title = $0 })
            .disposed(by: disposeBag)
    }

}

// MARK: UITableViewDataSource
extension ChartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieListData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.chart_table_cell) as? ChartTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(rank: indexPath.row, movie: viewModel.movieListData.value[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is ChartTableViewCell else { return }
        
        let detailVC = DetailViewController(id: viewModel.movieListData.value[indexPath.row].id)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

// MARK: Scroll Features
extension ChartViewController {
    
    // RefreshControll
    @objc private func refreshData() {
        
        var category: MovieListCategory? {
            switch navigationItem.title {
            case MovieListCategory.popular.title: return MovieListCategory.popular
            case MovieListCategory.topRated.title: return MovieListCategory.topRated
            case MovieListCategory.nowPlaying.title: return MovieListCategory.nowPlaying
            default: return nil
            }
        }
        
        if category != nil { self.viewModel.refreshData() }
        self.tableView.refreshControl?.endRefreshing()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.requestData(category: .popular)
        }
    }

}
