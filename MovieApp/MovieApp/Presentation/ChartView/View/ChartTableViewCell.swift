//
//  ChartTableViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit
import Then
import SnapKit
import Cosmos
import RxSwift

class ChartTableViewCell: UITableViewCell {
    
    let margin = 10.0
    private var disposeBag = DisposeBag()

    // MARK: UI Components
    lazy var rankLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        $0.sizeToFit()
        
        $0.setContentHuggingPriority(.required, for: .horizontal)                 // prevent stretching horizontally
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)   // prevent compressing horizontally
    }
    
    lazy var posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "img_placeholder")
    }
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 3
        $0.minimumScaleFactor = 10
    }
    
    lazy var genreLabel = UILabel().then {
        $0.textColor = UIColor.lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    lazy var releaseDateLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    lazy var starRating = { () -> CosmosView in
        let starView = CosmosView()
        starView.settings.totalStars = 5
        starView.settings.emptyBorderColor = .orange
        starView.settings.filledColor = .orange
        starView.settings.fillMode = .half
        starView.settings.updateOnTouch = false
        starView.settings.starSize = 17
        starView.settings.starMargin = 1
        return starView
    }()
    
    lazy var ratingCountLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }

    
    // MARK: initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: Group views into stack views
        let starStackView = UIStackView().then {
            $0.addArrangedSubview(starRating)
            $0.addArrangedSubview(ratingCountLabel)
            $0.addArrangedSubview(UIView())
            
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 5
        }
        
        let infoStackView = UIStackView().then {
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(genreLabel)
            $0.addArrangedSubview(releaseDateLabel)
            $0.addArrangedSubview(starStackView)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 5
        }

        self.backgroundColor = UIColor(named: Colors.background)
        self.selectionStyle = .none
        
        //MARK: Set Constraints
        self.addSubview(rankLabel)
        self.addSubview(posterImageView)
        self.addSubview(infoStackView)
        
        rankLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(-margin)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.left.equalTo(rankLabel.snp.right).offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(margin*(-1))
            make.width.equalTo(100)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(margin*(-2))
            make.right.equalToSuperview().offset(margin*(-1))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        self.posterImageView.image = UIImage(named: "img_placeholder")
    }
}

extension ChartTableViewCell {
    
    /// Set poster imageView placeholder Image
    private func setPosterPlaceholderImage() {
        self.posterImageView.image = UIImage(named: "img_placeholder")
    }
    
    // MARK: Set Data
    func setData(rank: Int, movie: MovieFront) {
        
        rankLabel.text = "\(rank+1)"
        titleLabel.text = movie.title
        genreLabel.text = movie.genre
        releaseDateLabel.text = movie.releaseDate
        starRating.rating = movie.ratingScore/2
        ratingCountLabel.text = "(\(movie.ratingCount))"
        if let imagePath = movie.posterPath {
            posterImageView.setImage(APIService.configureUrlString(imagePath: imagePath))
        }
    }
}
