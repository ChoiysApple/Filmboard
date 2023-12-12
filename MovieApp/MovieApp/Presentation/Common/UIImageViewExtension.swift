//
//  UIImageViewExtension.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/09/19.
//

import Foundation
import UIKit

// MARK: UIImageView Extension for setting images from url asynchronously
extension UIImageView {
    /// identifer for savedTask
    private static var taskKey = 0
    /// identifer for savedUrl
    private static var urlKey = 0
    
    /// associated objects of image downloading task
    private var savedTask: URLSessionTask? {
        get { objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    /// associated objects of URL used for downloading task
    private var savedUrl: URL? {
        get { objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension UIImageView {
    
    /**
     Load image from url String and change image of UIImageView
     - Parameters:
        - path: url string for target Image. If path is nil, return after retrive saved task and set placeholder image
        - placeholder: placeholder image to set before image loaded
     */
    func setImage(path: String?, placeholder: UIImage? = nil) {
        if let path, let url = URL(string: path) {
            self.setImage(with: URL(string: path), placeholder: placeholder)
        } else {
            self.setImage(with: nil, placeholder: placeholder)
        }
    }
    
    /**
     Load image from url String and change image of UIImageView
     - Parameters:
        - with: URL for target Image. If URL is nil, return after retrive saved task and set placeholder image
        - placeholder: placeholder image to set before image loaded
     */
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        
        self.savedTask?.cancel()
        self.savedTask = nil

        self.image = placeholder
        
        guard let url else { return }
        
        // Cache Image available
        if let cachedImage = ImageCacheManager.shared.loadCachedData(for: url.absoluteString) {
            self.image = cachedImage
            
        // Download new image
        } else {
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                
                if let error, (error as? URLError)?.code != .cancelled {
                    print(error)
                    return
                }
                
                guard let data, let image = UIImage(data: data) else {
                    print("Error: unable to decode image")
                    return
                }
                
                ImageCacheManager.shared.saveCacheData(of: image, for: url.absoluteString)
                if url == self?.savedUrl {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            
            self.savedUrl = url
            self.savedTask = task
            task.resume()
        }
    }
}
