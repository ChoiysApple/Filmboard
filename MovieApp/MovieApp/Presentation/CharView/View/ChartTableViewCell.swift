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

class ChartTableViewCell: UITableViewCell {
    
    let margin = 10.0

    //MARK: Properties
    lazy var rankLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        $0.sizeToFit()
    }
    
    lazy var posterImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "img_placeholder")    // placeholder image
    }
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 2
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

    
    //MARK: initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let starStackView = UIStackView().then {
            $0.addArrangedSubview(starRating)
            $0.addArrangedSubview(ratingCountLabel)
            
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }
        
        let infoStackView = UIStackView().then {
            
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(genreLabel)
            $0.addArrangedSubview(releaseDateLabel)
            $0.addArrangedSubview(starStackView)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }

        self.backgroundColor = UIColor(named: Colors.background)
        
        //MARK: Set Constraints
        self.addSubview(rankLabel)
        self.addSubview(posterImage)
        self.addSubview(infoStackView)
        
        rankLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(-margin)
        }
        
        posterImage.snp.makeConstraints { make in
            make.left.equalTo(rankLabel.snp.right).offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(margin*(-1))
            make.width.equalTo(100)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.right).offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(margin*(-2))
            make.right.lessThanOrEqualToSuperview().offset(margin*(-1.5))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set Data
    func setData(rank: Int, movie: MovieFront) {
        rankLabel.text = "\(rank+1)"
        titleLabel.text = movie.title
        genreLabel.text = movie.genre
        releaseDateLabel.text = movie.releaseDate
        starRating.rating = movie.ratingScore/2
        ratingCountLabel.text = "(\(movie.ratingCount))"
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: movie.posterPath) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
    }

}

extension ChartTableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        print(self.contentView.bounds.height)
    }
    
}
