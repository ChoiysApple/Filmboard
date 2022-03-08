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
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        tableView = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: Colors.background)
        tableView.separatorColor = UIColor(named: Colors.background)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifiers.credit_table_cell)
        tableView.bounces = false

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? ExternalLink.data.count : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifiers.credit_table_cell, for: indexPath) as UITableViewCell
            
            cell.backgroundColor = UIColor(named: Colors.light_background)
            cell.textLabel?.textColor = .white

            let data = ExternalLink.data[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = data.titleText
            
            cell.detailTextLabel?.text = data.detailText
            
            return cell
        } else {

            guard let data = CreditSection(rawValue: indexPath.section)?.data as? [String] else {
                let cell = UITableViewCell().then { $0.isHidden = true }
                return cell
            }
            return CreditTableViewDescriptionCell(title: data[0], description: data[1])
        }
            
    }
    
}

extension CreditViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? CreditHeaderView() : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let url = URL(string: ExternalLink.data[indexPath.row].url) { UIApplication.shared.open(url) }
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }

    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 40 : 100
//    }
    
    
}

