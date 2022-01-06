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
        $0.font = UIFont.systemFont(ofSize: 32)
        $0.text = "Discover Movies"
    }
    
    lazy var searchField = PaddingTextField().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: Colors.light_background)
        let placeholderColor = UIColor(named: Colors.placeholder) ?? UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        // Image on Left
//        var imageView = UIImageView()
//        imageView.image = UIImage(named: "magnifyingglass")
//        $0.leftView = imageView
//        $0.leftViewMode = .always
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
        
        self.addSubview(titleLabel)
        self.addSubview(searchField)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
}

// Text Field with textpadding
class PaddingTextField: UITextField {
    
    let textPadding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
