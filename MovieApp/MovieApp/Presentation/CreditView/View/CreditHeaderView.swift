//
//  CreditHeaderView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/03/07.
//

import Foundation
import UIKit

class CreditHeaderView: UITableViewHeaderFooterView {
    
    lazy var appIconImageView = UIImageView().then {
        $0.image = UIImage.appIcon
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var descriptionLabel = DescriptionView().then {
        $0.titleLabel.text = "Filmboard"
        $0.titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        $0.contentLabel.text = "Open source Movie app using MVVM"
        UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.topDivider.isHidden = true
    }
    
    lazy var stack = UIStackView().then {
        $0.addArrangedSubview(appIconImageView)
        $0.addArrangedSubview(descriptionLabel)
        
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets.detailViewComponentInset
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
    
        appIconImageView.snp.makeConstraints { $0.height.equalTo(appIconImageView.snp.width) }
    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(stack)
        
        stack.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
