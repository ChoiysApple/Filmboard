//
//  UIImageViewExtension.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/09/19.
//

import Foundation
import UIKit

extension UIImageView {
    private static var taskKey = 0
    private static var urlKey = 0
    
    private var savedTask: URLSessionTask? {
        get { objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var savedUrl: URL? {
        get { objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension UIImageView {
    
    func setImage(path: String?, placeholder: UIImage? = nil) {
        guard let path else {
            self.savedTask?.cancel()
            self.savedTask = nil
            self.image = placeholder
            return
        }
        self.setImage(with: URL(string: path), placeholder: placeholder)
    }
    
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
