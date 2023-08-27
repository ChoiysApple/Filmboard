//
//  DiscoverCollectionViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/06.
//

import UIKit
import SnapKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    var contentId: Int?
    
    //MARK: Create properties
    lazy var posterImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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
            $0.addArrangedSubview(posterImage)
            $0.addArrangedSubview(movieTitle)
            
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 0
        }
        
        // add to view
        self.contentView.addSubview(stackView)
        
        //MARK: Add Constraints
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        posterImage.snp.makeConstraints { make in
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
    func setData(movie: MovieFront) {
        
        
        self.posterImage.image = UIImage(named: "img_placeholder")
        self.movieTitle.text = movie.title
        self.contentId = movie.id
        
        DispatchQueue.global().async {
            
            guard let imagePath = movie.posterPath else { return }
            guard let imageURL = URL(string: APIService.configureUrlString(imagePath: imagePath)) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
        
    }
}
