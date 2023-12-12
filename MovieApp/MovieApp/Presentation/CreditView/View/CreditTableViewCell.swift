//
//  CreditTableViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/12/04.
//

import UIKit

class CreditTableViewCell: UITableViewCell, ReusableCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        self.backgroundColor = UIColor(named: UIColor.lightBackground)
        self.textLabel?.textColor = .white
        self.accessoryType = .disclosureIndicator
    }
}

extension CreditTableViewCell {
    
    func setData(_ title: String, _ detail: String) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = detail
    }
    
    func setData(_ data: ExternalLink) {
        self.setData(data.titleText, data.detailText)
    }
}
