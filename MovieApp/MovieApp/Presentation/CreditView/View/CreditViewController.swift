//
//  CreditViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/10.
//

import UIKit
import Then
import SnapKit

// Because this view is not changing, Not using Rx

class CreditViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: UIColor.background)
        
        tableView = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: UIColor.background)
        tableView.separatorColor = UIColor(named: UIColor.background)
        tableView.register(CreditTableViewCell.self)
        tableView.register(CreditTableViewDescriptionCell.self)
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

// MARK: DataSource
extension CreditViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? ExternalLink.data.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(CreditTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
            }

            let data = ExternalLink.data[indexPath.row]
            cell.setData(data)
            return cell
            
        } else {

            guard let data = CreditSection(rawValue: indexPath.section)?.data as? [String],
                  let cell = tableView.dequeueReusableCell(CreditTableViewDescriptionCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            
            cell.setUpData(title: data[0], description: data[1])
            return cell
        }
            
    }
    
}

extension CreditViewController: UITableViewDelegate {
        
    // MARK: Header & Footer
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? CreditHeaderView() : nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return section == CreditSection.allCases.count-1 ? CreditFootherView() : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == CreditSection.allCases.count-1 ? 50 : 0
    }
    
    // MARK: Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let url = URL(string: ExternalLink.data[indexPath.row].url) { UIApplication.shared.open(url) }
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }

    }
        
}
