//
//  DoubleColumDescriptionView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/16.
//

import UIKit

class DoubleColumDescriptionView: UIView {
    
    lazy var leftDescription = DescriptionView()
    lazy var rightDescription = DescriptionView()
    
    lazy var wrapperStack = UIStackView().then {
        $0.addArrangedSubview(leftDescription)
        $0.addArrangedSubview(rightDescription)
        
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 0
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

        addSubview(wrapperStack)
        
        wrapperStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
