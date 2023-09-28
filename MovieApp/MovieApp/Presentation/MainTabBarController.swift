//
//  TabBarController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let appearance = UITabBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = UIColor(named: UIColor.light_background)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .white

        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let discoverItem = DiscoverViewController()
        discoverItem.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        let discoverNavigationItem = UINavigationController(rootViewController: discoverItem)
                
        let chartItem = ChartViewController()
        chartItem.tabBarItem = UITabBarItem(title: "Charts", image: UIImage(systemName: "list.number"), selectedImage: UIImage(systemName: "list.number"))
        let chartNavigationItem = UINavigationController(rootViewController: chartItem)
        
        let elseItem = CreditViewController()
        elseItem.tabBarItem = UITabBarItem(title: "Credit", image: UIImage(systemName: "ellipsis"), selectedImage: UIImage(systemName: "Credits"))
        

        self.viewControllers = [discoverNavigationItem, chartNavigationItem, elseItem]
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
    
}
