//
//  SingleRowHorizontalCollectionFlowLayout.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/02/17.
//

import UIKit

extension UIEdgeInsets {
    static let detailViewComponentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
}

extension UIImage {
    
    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
              let icon = iconFiles.last else { return nil }
        return UIImage(named: icon)
    }
    
}

extension UIColor {
    static let background = "BgColor"
    static let lightBackground = "LightBgColor"
    static let placeholder = "PlaceholderTextColor"
}
