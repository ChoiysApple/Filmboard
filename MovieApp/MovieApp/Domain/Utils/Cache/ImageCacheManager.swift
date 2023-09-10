//
//  ImageCacheManager.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/08/05.
//

import UIKit

/// Singleton for Image Caching
class ImageCacheManager {
    
    /// Storage to save cached UIImage
    private let cache = Cache<String, UIImage>()
    
    /// singleton instance
    static let shared = ImageCacheManager()
    
    /**
    Get image from cache data for url String
    - Parameter key:  String url of UIImage
    - Returns: Retrun cached image for url. Retrun nil when cached image is not exist
    */
    func loadCachedData(for key: String) -> UIImage? {
        let itemURL = NSString(string: key)
        return cache.value(forKey: key)
    }
    
    /**
    Save UIImage to cache data
     - Parameters:
        - image: UIImage to save in cache data
        - key:  String url of UIImage
     */
    func saveCacheData(of image: UIImage, for key: String) {
        let itemURL = NSString(string: key)
        cache.insertValue(image, forKey: key)
    }
}

extension UIImageView {

    /**
     Set image to UIImageView with Cached Image data or data from URL
     - Parameters:
        - urlString: String url of image
        - forceOption: Skip getting image from cache data and force to get image from url when true. default false
     */
    func setImage(_ urlString: String?, forceOption: Bool = false) {
        
        DispatchQueue.global().async {
            guard let imagePath = urlString else { return }
            
            // Cached Image is available
            if let cachedData = ImageCacheManager.shared.loadCachedData(for: imagePath), forceOption == false {
                DispatchQueue.main.async {
                    self.image = cachedData
                }
                
            // No Image Cached
            } else {
                guard let imageURL = URL(string: imagePath) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                guard let newImage = UIImage(data: imageData) else { return }
                
                ImageCacheManager.shared.saveCacheData(of: newImage, for: imagePath)
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func cancelImageLoading() {
        
    }
}
