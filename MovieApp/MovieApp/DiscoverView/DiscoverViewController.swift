//
//  ViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/03.
//

import UIKit
import SnapKit
import Then

class DiscoverViewController: UIViewController {
    
    lazy var collectionView = { () -> UICollectionView in
    
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 60, height: 60)

        return UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        initUI()
    }


}

//MARK: Draw UI
extension DiscoverViewController {
    
    private func initUI() {
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DiscoverCollectionCell")

        super.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(named: ColorName.background_color)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
    }
    
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionCell", for: indexPath)
        cell.backgroundColor = .blue
        
        return cell
    }
    
    
}

extension DiscoverViewController: UICollectionViewDelegate {
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
