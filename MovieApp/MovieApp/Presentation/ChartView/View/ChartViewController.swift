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
        
        
        configureNavigation()
        applyConstraint()
        bindData()

        viewModel.requestData()
    }
    
    @objc func addTapped() {
        print(#function)
    }
    
    //MARK: UI Properties
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: Colors.background)
        $0.allowsSelection = false
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: identifiers.chart_table_cell)
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
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.title = "Popular"
        
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: .plain, target: self, action: #selector(addTapped))
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
    }
    
    

}

extension ChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

