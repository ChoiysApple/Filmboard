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


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
