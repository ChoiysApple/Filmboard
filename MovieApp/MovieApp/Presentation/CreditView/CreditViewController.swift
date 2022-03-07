//
//  CreditViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/10.
//

import UIKit
import Then
import SnapKit

class CreditViewController: UIViewController {
    
    let contentView = UIView()
    
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: Colors.background)
        $0.register(UITableViewCell.self, forCellReuseIdentifier: identifiers.credit_table_cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        applyConstraint()
    }
    
    private func applyConstraint() {
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
    }
    


}

extension CreditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Credit.data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers.credit_table_cell, for: indexPath) as UITableViewCell
        
        cell.backgroundColor = UIColor(named: Colors.background)
        
        let data = Credit.data[indexPath.row]
        cell.imageView?.image = UIImage(named: data.imageName)
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        
        cell.textLabel?.text = data.titleText
        cell.textLabel?.textColor = .white
        
        cell.detailTextLabel?.text = data.detailText
        
        return cell
    }
    
}

extension CreditViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}
