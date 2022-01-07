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
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = .white
        $0.numberOfLines = 2
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add to view
        self.addSubview(posterImage)
        self.addSubview(movieTitle)
        
        //MARK: Add Constraints
        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(5)
            make.bottom.greaterThanOrEqualToSuperview()
            make.leading.equalTo(posterImage.snp.leading)
            make.trailing.equalTo(posterImage.snp.trailing)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Insert data to cell
extension DiscoverCollectionViewCell {
    func insertData(imageURLString: String, title: String) {
        
        movieTitle.text = title
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: imageURLString) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data: imageData)
            }
        }

    }

}
