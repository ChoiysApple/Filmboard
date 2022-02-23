//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/14.
//

import SnapKit
import Foundation
import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    let viewModel: DetailViewModel
    let disposeBag = DisposeBag()
    
    //MARK: Initializer
    init (id: Int) {
        self.viewModel = DetailViewModel(contentId: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: UI Componemts
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var backButton = UIButton().then {
        $0.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        $0.imageView?.image = UIImage(systemName: "chevron.backward.circle")
        $0.imageView?.tintColor = .white
    }
    
    @objc private func backButtonAction() {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: BackDrop
    lazy var backDropImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .darkGray
    }
    
    //MARK: Main Info
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        
        $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        $0.numberOfLines = 0
        $0.minimumScaleFactor = 10
        
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    lazy var taglineLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    lazy var runtimeIconLabel = IconLabel().then {
        $0.icon.image = UIImage(systemName: "clock")
    }
    
    lazy var ratingIconLabel = IconLabel().then {
        $0.icon.image = UIImage(systemName: "star.fill")
        $0.icon.tintColor = .orange
    }
    
    lazy var iconLabels = UIStackView().then {
        $0.addArrangedSubview(runtimeIconLabel)
        $0.addArrangedSubview(ratingIconLabel)
        
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 5
    }
    
    lazy var mainInfoLabelStack = UIStackView().then {
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(taglineLabel)
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(iconLabels)
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 5
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets.detailViewComponentInset
    }
    
    //MARK: - Overview
    lazy var overview = DescriptionView().then { $0.titleLabel.text = "Overview" }
    
    //MARK: Date & Genre
    lazy var dateGenre = DoubleColumDescriptionView().then {
        $0.leftDescription.titleLabel.text = "Release Date"
        $0.rightDescription.titleLabel.text = "Genre"
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.sectionInset = UIEdgeInsets.detailViewComponentInset
        $0.itemSize = CGSize(width: 60, height: 60)
        $0.scrollDirection = .horizontal
    }

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        bindData()
        applyConstraint()
    }
    
    
    //MARK: Bind Data
    private func bindData() {
        
        // main
        _ = viewModel.movieDetailObservable.observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                
                guard let movieDetail = data else { return }
                self.applyMovieDetailData(data: movieDetail)
            }).disposed(by: disposeBag)
    }
    
    private func applyConstraint() {
        
        //MARK: Setup Scrollview
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        //MARK: Setup ContentView
        // Add Sub View
        contentView.addSubview(backButton)
        contentView.addSubview(backDropImage)
        contentView.addSubview(mainInfoLabelStack)
        contentView.addSubview(overview)
        contentView.addSubview(dateGenre)
        
        // Set Constraint
        backDropImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(backDropImage.snp.width).multipliedBy(0.7)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            
            make.height.equalTo(backDropImage.snp.height).multipliedBy(0.15)
            make.width.equalTo(backButton.snp.height)
        }
        
        mainInfoLabelStack.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(0.325)
        }
        
        appendView(view: overview, target: mainInfoLabelStack)
        appendView(view: dateGenre, target: overview)
        
        dateGenre.snp.makeConstraints{ $0.bottom.equalToSuperview() }
    }
    
    //MARK: Binding Helper
    private func applyMovieDetailData(data: MovieDetail) {
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: APIService.configureUrlString(imagePath: data.backdropPath)) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.backDropImage.image = UIImage(data: imageData)
            }
        }
        
        self.titleLabel.text = data.title
        self.taglineLabel.text = data.tagline
        
        self.runtimeIconLabel.label.text = "\(data.runtime) min"
        self.ratingIconLabel.label.text = String(data.voteAverage)
        
        self.overview.contentLabel.text = data.overview
        self.dateGenre.leftDescription.contentLabel.text = data.releaseDate.replacingOccurrences(of: "-", with: ".")
        
        let genres = data.genres.map { $0.name }.joined(separator: ", ")
        self.dateGenre.rightDescription.contentLabel.text = genres
        
    }
        
}

//MARK: Constraint Funciton
extension DetailViewController {
        
    // Add Constrant to put new-UIView below target-UIView
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
    DetailViewController(id: 634649)
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
