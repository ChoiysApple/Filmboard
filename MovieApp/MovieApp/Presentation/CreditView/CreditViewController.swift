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
    
//    lazy var appIconImage = UIImageView().then {
//        $0.image = UIImage.appIcon
//        $0.layer.cornerRadius = 10
//        $0.clipsToBounds = true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        
        tableView.dataSource = self
//        tableView.delegate = self
        
        
        applyConstraint()
    }
    
    private func applyConstraint() {
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
    }
    


}

extension CreditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers.credit_table_cell, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row)"
//        cell.imageView?.image = UIImage.appIcon
//        cell.textLabel?.text = "text"
//        cell.detailTextLabel?.text = "detail"
                
        return cell
    }
    
}
