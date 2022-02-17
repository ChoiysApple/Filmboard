//
//  DescriptionView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/16.
//

import UIKit

class DescriptionView: UIView {
    
    lazy var topDivider = UIView().then {
        $0.backgroundColor = .gray
        $0.isHidden = false
    }

    lazy var label = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 0
        $0.minimumScaleFactor = 10
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    lazy var contentLabel = UILabel().then {
        
        $0.numberOfLines = 0
        $0.textColor = .lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    lazy var stack = UIStackView().then {
        
        $0.addArrangedSubview(label)
        $0.addArrangedSubview(contentLabel)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets.detailViewComponentInset
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        
        self.addSubview(stack)

        stack.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
        
        // Add Divider Line
        self.addSubview(topDivider)
        
        topDivider.snp.makeConstraints { make in
            make.height.equalTo(0.4)
            make.centerY.equalTo(self.snp.top)
            make.left.right.equalToSuperview()
        }
    }


}
