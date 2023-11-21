//
//  iconLabel.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/16.
//

import UIKit
import SnapKit

class IconLabel: UIView {
    
    lazy var icon = UIImageView().then {
        $0.tintColor = .lightGray
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    lazy var label = UILabel().then {
        $0.textColor = .lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    lazy var stack = UIStackView().then {
        
        $0.addArrangedSubview(icon)
        $0.addArrangedSubview(label)

        icon.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(icon.snp.height)
        }
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
    }
    
    // initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // common func to init our view
    private func setupView() {
      self.addSubview(stack)
      
      stack.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
    }
    
}
