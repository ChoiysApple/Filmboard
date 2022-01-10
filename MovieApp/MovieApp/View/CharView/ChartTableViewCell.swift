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
    
    let margin = 10

    lazy var rankLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 30, weight: .medium)
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
        starView.settings.starSize = 15
        return starView
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let infoStackView = UIStackView().then {
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(genreLabel)
            $0.addArrangedSubview(releaseDateLabel)
            $0.addArrangedSubview(starRating)
            
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
            
            make.width.equalTo(30)
        }
        
        posterImage.snp.makeConstraints { make in
            make.left.equalTo(rankLabel.snp.right).offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(margin*(-1))
        }
        
        infoStackView.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.right).offset(margin)
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(margin*(-1))
            make.right.lessThanOrEqualToSuperview().offset(margin*(-1))
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension ChartTableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSampleData(rank: Int) {
        rankLabel.text = "\(rank+1)"
        titleLabel.text = "Title"
        genreLabel.text = "Comdey"
        releaseDateLabel.text = "2022.00.00"
        starRating.rating = 3.0
    }
}
