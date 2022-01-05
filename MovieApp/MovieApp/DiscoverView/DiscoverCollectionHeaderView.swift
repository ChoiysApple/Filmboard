//
//  DiscoverCollectionHeaderView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/05.
//

import UIKit
import SnapKit
import Then

class DiscoverCollectionHeaderView: UICollectionReusableView {
    
    //MARK: UI Properties
    lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont(name: "AvenirNext-medium", size: 32.0)!
    }
    lazy var searchField = UITextField().then {
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 10
        $0.backgroundColor = .black
        $0.placeholder = "Search..."
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DiscoverCollectionHeaderView {
    private func configure() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(50)
        }
        
    }
}
