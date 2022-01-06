//
//  DiscoverCollectionViewCell.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/06.
//

import UIKit
import SnapKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    lazy var posterImage = UIImageView().then {
        $0.image = UIImage(named: "img_placeholder")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var movieTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .white
    }
    
    func insertData(imageURLString: String, title: String) {
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: imageURLString) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data: imageData)
            }
        }

        movieTitle.text = title
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        
        self.addSubview(posterImage)
        self.addSubview(movieTitle)
        
        
        
        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(10)
            make.bottom.greaterThanOrEqualToSuperview()
            make.leading.equalTo(posterImage.snp.leading)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
