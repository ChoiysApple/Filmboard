//
//  ReuseIdentifiable.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2023/11/25.
//

import Foundation

/// Protocol to use reuseIdentifier of UITableView's or UICollectionView's Cell as thier class name
protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
