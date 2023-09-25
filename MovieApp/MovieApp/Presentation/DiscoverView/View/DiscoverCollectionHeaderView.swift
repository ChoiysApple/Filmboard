//
//  DiscoverCollectionHeaderView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/05.
//

import UIKit
import SnapKit
import Then
import RxSwift

class DiscoverCollectionHeaderView: UICollectionReusableView {
    
    let viewModel = DiscoverViewModel.shared
    let disposeBag = DisposeBag()
    
    //MARK: UI Properties
    lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.text = "Discover Movies"
    }
    
    lazy var searchField = PaddingTextField().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: UIColor.light_background)
        $0.textColor = .white
        
        let placeholderColor = UIColor(named: UIColor.placeholder) ?? UIColor.lightGray
        $0.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        bindSearchField()

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
    
    private func bindSearchField() {
        self.searchField.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .distinctUntilChanged()
            .subscribe(onNext: {
                self.viewModel.requestData(keyword: $0, page: 1) })
            .disposed(by: disposeBag)
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
