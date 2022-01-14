//
//  ChartViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit
import SnapKit

class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: Colors.background)
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: identifiers.chart_table_cell)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        
//        tableView.delegate = self
        tableView.dataSource = self
        
        
        //MARK: Draw UI
        
        tableView.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }

    }
    
}

//MARK: -Data Source
extension ChartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifiers.chart_table_cell, for: indexPath) as? ChartTableViewCell else { fatalError("Unable to dequeue ReminderCell") }
        
        cell.setData(rank: indexPath.row, movie: viewModel.movies[indexPath.row])
        
        return cell
    }
    
    
}
