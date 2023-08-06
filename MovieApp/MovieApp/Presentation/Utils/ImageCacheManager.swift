//
//  ImageCacheManager.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/08/05.
//

import UIKit

/// Singleton for Image Caching
class ImageCacheManager {
    private let cache = NSCache<NSString, UIImage>()
    static let shared = ImageCacheManager()
    
    private init() {}
    
    func loadCachedData(for key: String) -> UIImage? {
        let itemURL = NSString(string: key)
        return cache.object(forKey: itemURL)
    }
    
    func saveCacheData(of image: UIImage, for key: String) {
        let itemURL = NSString(string: key)
        cache.setObject(image, forKey: itemURL)
    }
}

extension UIImageView {
    
    /// Set image to UIImageView with Cached Image data or data from URL
    func setImage(_ urlString: String?) {
        
        DispatchQueue.global().async {
            guard let imagePath = urlString else { return }
            
            // Cached Image is available
            if let cachedData = ImageCacheManager.shared.loadCachedData(for: imagePath) {
                DispatchQueue.main.async {
                    self.image = cachedData
                }
                
            // No Image Cached
            } else {
                guard let imageURL = URL(string: APIService.configureUrlString(imagePath: imagePath)) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
