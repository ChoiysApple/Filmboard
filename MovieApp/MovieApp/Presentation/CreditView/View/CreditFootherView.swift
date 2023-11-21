//
//  CreditFootherView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/03/08.
//

import UIKit

class CreditFootherView: UITableViewHeaderFooterView {
    
    lazy var label = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        $0.text = "MIT License | Copyright (c) 2022 Daegun Choi"
    }
    
    lazy var topDivider = UIView().then {
        $0.backgroundColor = .gray
        $0.isHidden = false
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        self.addSubview(topDivider)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        topDivider.snp.makeConstraints { make in
            make.height.equalTo(0.3)
            make.centerY.equalTo(label.snp.top).offset(-5)
            make.left.equalTo(label.snp.left)
            make.right.equalTo(label.snp.right)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
