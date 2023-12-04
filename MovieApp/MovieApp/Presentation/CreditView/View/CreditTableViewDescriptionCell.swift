//
//  CreditTableViewDescriptionCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/03/08.
//

import UIKit

class CreditTableViewDescriptionCell: UITableViewCell, ReusableCell {

    lazy var descriptionView = DescriptionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.addSubview(descriptionView)
        descriptionView.backgroundColor = UIColor(named: UIColor.background)
        descriptionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setUpData(title: String, description: String) {
        descriptionView.titleLabel.text = title
        descriptionView.contentLabel.text = description
        
        descriptionView.topDivider.isHidden = true
        descriptionView.titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        descriptionView.contentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }

}
