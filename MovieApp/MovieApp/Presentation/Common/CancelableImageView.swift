//
//  CancelableImageView.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/09/11.
//

import Foundation
import UIKit

/// UIImageView with async image loading functions
class CancelableImageView: UIImageView {
    
    /// Cocurrent image loading work item
    private var imageLoadingWorkItem: DispatchWorkItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
}

// MARK: Concurrent image loading method
extension CancelableImageView {
    
    /**
     Cancel current image loading task and Set image to UIImageView with Cached Image data or data from URL
     - Parameters:
        - urlString: String url of image
        - forceOption: Skip getting image from cache data and force to get image from url when true. default false
     */
    func setNewImage(_ urlString: String?, forceOption: Bool = false, index: Int? = nil) {
        
        self.cancelLoadingImage()
        self.imageLoadingWorkItem = DispatchWorkItem { super.setImage(urlString, forceOption: forceOption) }
        self.imageLoadingWorkItem?.perform()
//        if let workItem = imageLoadingWorkItem {
//            DispatchQueue.global().async(execute: workItem)
//        }
    }
    
    /// Cancel current image loading work
    func cancelLoadingImage() {
        DispatchQueue.global().async {
            self.imageLoadingWorkItem?.cancel()
        }
    }
}
