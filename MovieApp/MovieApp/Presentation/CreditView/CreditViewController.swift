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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Colors.background)

        let label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            $0.textColor = .white
            $0.text = "This is Credit Page"
        }
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }


}
