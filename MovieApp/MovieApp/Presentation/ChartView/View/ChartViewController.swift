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
    
    let viewModel = ChartViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        
        let customRefreshControl = UIRefreshControl().then{  $0.tintColor = .white }
        tableView.refreshControl = customRefreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        
        configureNavigation()
        applyConstraint()
        bindData()

        viewModel.requestData(category: .Popular)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
        
    //MARK: Instances
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: Colors.background)
        $0.allowsSelection = true
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: identifiers.chart_table_cell)
        
        let spinner = UIActivityIndicatorView(style: .medium)
        $0.tableFooterView = spinner
        $0.tableFooterView?.isHidden = true
    }
    
    let navigationAppearance = UINavigationBarAppearance().then {
        $0.titleTextAttributes = [.foregroundColor: UIColor.white]
        $0.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        $0.backgroundColor = UIColor(named: Colors.background)
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        //MARK: Category Menu
        let categoryMenuItem = [
            UIAction(title: "Popular", image: UIImage(systemName: "flame.fill"), handler: { _ in self.viewModel.requestData(category: .Popular) }),
            UIAction(title: "Top Rated", image: UIImage(systemName: "star.fill"), handler: { _ in self.viewModel.requestData(category: .TopRated) }),
            UIAction(title: "Now Playing", image: UIImage(systemName: "theatermasks.fill"), handler: { _ in self.viewModel.requestData(category: .NowPlaying) })
        ]
        let categoryMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: categoryMenuItem)
        
        // NavigationBatItem
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), primaryAction: nil, menu: categoryMenu)
        categoryButton.tintColor = .white
        navigationItem.rightBarButtonItem = categoryButton
        
    }
    
    
    private func applyConstraint() {
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
    
    //MARK: Data Binding
    private func bindData() {
        viewModel.movieFrontObservable
            .bind(to: tableView.rx.items(cellIdentifier: identifiers.chart_table_cell, cellType: ChartTableViewCell.self)) { index, movie, cell in
                cell.setData(rank: index, movie: movie)
            }
            .disposed(by: disposeBag)
        
        _ = viewModel.listTitleObaservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { self.navigationItem.title = $0 })
    }


}

//MARK: Cell Selection
extension ChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ChartTableViewCell else { return }
        guard let id = cell.contentId else { return }
        
        let vc = DetailViewController(id: id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: Cell Height
extension ChartViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

//MARK: Scroll Features
extension ChartViewController {
    
    // RefreshControll
    @objc private func refreshData() {
        
        var category: MovieListCategory? {
            switch (self.navigationItem.title){
            case MovieListCategory.Popular.title: return MovieListCategory.Popular
            case MovieListCategory.TopRated.title: return MovieListCategory.TopRated
            case MovieListCategory.NowPlaying.title: return MovieListCategory.NowPlaying
            default: return nil
            }
        }
        
        if let _ = category { self.viewModel.refreshData() }
        self.tableView.refreshControl?.endRefreshing()
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.requestData(category: .Popular)
        }
    }

}

