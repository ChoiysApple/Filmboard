//
//  CreditTableViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/12/04.
//

import UIKit

class CreditTableViewCell: UITableViewCell, ReusableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(named: UIColor.lightBackground)
        self.textLabel?.textColor = .white
    }

}
