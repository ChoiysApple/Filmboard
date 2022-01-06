//
//  ViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/03.
//

import UIKit
import SnapKit

class DiscoverViewController: UIViewController {
    
    lazy var collectionView = { () -> UICollectionView in
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: self.preferredContentSize.width, height: 180)

        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        
        flowLayout.itemSize = CGSize(width: 170, height: 270)
        
        return UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        //MARK: Draw UI
        collectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: identifiers.discover_collection_cell)
        collectionView.register(DiscoverCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifiers.discover_collection_header)

        collectionView.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
    }


}

//MARK: -Draw UI

//MARK: - Collection View Configuration
//TODO: Will be deleted when RxCocoa added
extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Sample Cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return UICollectionViewCell() }
                
        cell.insertData(imageURLString: "", title: "Movie")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: identifiers.discover_collection_header,
              for: indexPath)
    }
    
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}



#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    DiscoverViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
        
    }
} #endif
