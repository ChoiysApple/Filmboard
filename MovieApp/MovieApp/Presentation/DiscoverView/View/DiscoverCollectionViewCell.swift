//
//  DiscoverCollectionViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/06.
//

import UIKit
import SnapKit
import RxSwift

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    // MARK: Create properties
    lazy var posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "img_placeholder")
    }
    
    lazy var movieTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .white
        $0.numberOfLines = 3
        $0.minimumScaleFactor = 5
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView().then {
            $0.addArrangedSubview(posterImageView)
            $0.addArrangedSubview(movieTitle)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 0
        }
        
        // add to view
        self.contentView.addSubview(stackView)
        
        // MARK: Add Constraints
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        posterImageView.snp.makeConstraints { make in
            make.left.right.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }

        movieTitle.setContentHuggingPriority(.required, for: .vertical)                 // prevent stretching vertically
        movieTitle.setContentCompressionResistancePriority(.required, for: .vertical)   // prevent compressing vertically
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: Insert data to cell
extension DiscoverCollectionViewCell {
    
    /// Set movie data to cell
    func setData(movie: MovieFront) {
        self.movieTitle.text = movie.title
        
        let imagePath = APIService.configureUrlString(imagePath: movie.posterPath)
        let placeholder = UIImage(named: "img_placeholder")
        posterImageView.setImage(path: imagePath, placeholder: placeholder)
    }
}
