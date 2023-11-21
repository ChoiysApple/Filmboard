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
        return cache.value(forKey: key)
    }
    
    /**
    Save UIImage to cache data
     - Parameters:
        - image: UIImage to save in cache data
        - key:  String url of UIImage
     */
    func saveCacheData(of image: UIImage, for key: String) {
        cache.insertValue(image, forKey: key)
    }
}
