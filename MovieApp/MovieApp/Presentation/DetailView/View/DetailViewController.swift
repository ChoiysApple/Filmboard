//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/14.
//

import SnapKit
import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: BackDrop
    lazy var backDropImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .darkGray
    }
    
    //MARK: Main Info
    lazy var posterImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "img_placeholder")    // placeholder image
        
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Title"
        $0.textColor = .white
        $0.textAlignment = .left
        
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 0
        $0.minimumScaleFactor = 10
        
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    lazy var runtimeIcon = UIImageView().then {
        $0.image = UIImage(systemName: "clock")
        $0.tintColor = .lightGray
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    lazy var runtimeLabel = UILabel().then {
        $0.text = "000"         // placeholder
        $0.textColor = .lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    lazy var runtimeStack = UIStackView().then {
        
        $0.addArrangedSubview(runtimeIcon)
        $0.addArrangedSubview(runtimeLabel)

        runtimeIcon.snp.makeConstraints { make in
            make.height.equalTo(runtimeLabel.snp.height)
            make.width.equalTo(runtimeIcon.snp.height)
        }
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
    }
    
    lazy var ratingIcon = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .orange
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    lazy var ratingLabel = UILabel().then {
        $0.text = "0.0"         // placeholder
        $0.textColor = .lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
    }
    
    lazy var ratingStack = UIStackView().then {
        
        $0.addArrangedSubview(ratingIcon)
        $0.addArrangedSubview(ratingLabel)
        
        ratingIcon.snp.makeConstraints { make in
            make.height.equalTo(ratingLabel.snp.height)
            make.width.equalTo(ratingIcon.snp.height)
        }

        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
    }
    
    lazy var mainInfoLabelStack = UIStackView().then {
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(runtimeStack)
        $0.addArrangedSubview(ratingStack)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 5
    }
        
    lazy var mainInfoStackView = UIStackView().then {
        $0.addArrangedSubview(posterImage)
        $0.addArrangedSubview(mainInfoLabelStack)
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        bindData()
        applyConstraint()
    }
    
    private func bindData() {
        
    }
    
    //MARK: Constraints
    private func applyConstraint() {
        
        let dividerView = UIView().then {
            
            $0.backgroundColor = .gray
            $0.snp.makeConstraints { make in
                make.height.equalTo(0.5)
            }
        
        }
        let dividerArray = Array(repeating: dividerView, count: 4)
        
        // Add to Subview
        self.view.addSubview(backDropImage)
        self.view.addSubview(mainInfoStackView)
        dividerArray.forEach{ self.view.addSubview($0) }
        
        // Set Constraint
        backDropImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(backDropImage.snp.width).multipliedBy(0.5)
        }
        
        mainInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        dividerArray[0].snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalTo(mainInfoStackView.snp.bottom)
        }
                
    }
    
}


#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    DetailViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Mini"))
        }
    }
} #endif
