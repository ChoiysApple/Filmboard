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
    
    let scrollView = UIScrollView()
    let contentView = UIView()

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
        
        $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        $0.numberOfLines = 0
        $0.minimumScaleFactor = 10
        
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    lazy var runtimeIconLabel = IconLabel().then {
        $0.icon.image = UIImage(systemName: "clock")
        $0.label.text = "000"
    }
    
    lazy var ratingIconLabel = IconLabel().then {
        $0.icon.image = UIImage(systemName: "star.fill")
        $0.icon.tintColor = .orange
        $0.label.text = "0.0"
    }
    
    lazy var mainInfoLabelStack = UIStackView().then {
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(runtimeIconLabel)
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(ratingIconLabel)
        
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
        $0.layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 20)
    }
    
    //MARK: - Overview
    lazy var overviewStack = DescriptionView().then {
        $0.label.text = "Overview"
        $0.contentLabel.text = "The only difference between a problem and a solution is that people understand the solution" //placeholder
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
        
        //MARK: Setup Scrollview
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        //MARK: Setup ContentView
        // Add Sub View
        contentView.addSubview(backDropImage)
        contentView.addSubview(mainInfoStackView)
        contentView.addSubview(overviewStack)
                
        // Set Constraint
        backDropImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(backDropImage.snp.width).multipliedBy(0.5)
        }
        
        mainInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(0.45)
        }
        
        appendView(view: overviewStack, target: mainInfoStackView)
        
    }
    
}


extension DetailViewController {
        
    // Place UIView to bottom anchor of target
    private func appendView(view: UIView, target: UIView) {
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(target.snp.bottom)
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
