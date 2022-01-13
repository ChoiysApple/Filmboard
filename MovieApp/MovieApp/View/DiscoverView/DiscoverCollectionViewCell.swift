//
//  DiscoverCollectionViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/06.
//

import UIKit
import SnapKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    //MARK: Create properties
    lazy var posterImage = UIImageView().then {
        $0.image = UIImage(named: "img_placeholder")
        $0.contentMode = .scaleAspectFit

    }
    
    lazy var movieTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        $0.numberOfLines = 2
        $0.minimumScaleFactor = 10
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
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview().offset(-40)
        }

        movieTitle.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(40)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Insert data to cell
extension DiscoverCollectionViewCell {
    func setData(movie: MovieFront) {
        
        self.movieTitle.text = movie.title
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: "https://image.tmdb.org/t/p/original/\(movie.posterPath)") else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
        
    }
}
