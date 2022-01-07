//
//  TabBarController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let discoverItem = DiscoverViewController()
        discoverItem.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named: "film"), selectedImage: UIImage(named: "film.fill"))
        
        let chartItem = ChartViewController()
        discoverItem.tabBarItem = UITabBarItem(title: "Chart", image: UIImage(named: "list.and.film"), selectedImage: UIImage(named: "list.and.film"))
        
        
        self.viewControllers = [discoverItem, chartItem]
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }

}
