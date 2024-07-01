//
//  TabBarController.swift
//  MediaProject
//
//  Created by 전준영 on 6/24/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .systemPink
        tabBar.unselectedItemTintColor = .gray
        
        let mediaVC = MediaViewController()
        let nav1 = UINavigationController(rootViewController: mediaVC)
        nav1.tabBarItem = UITabBarItem(title: "미디어", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let movieVC = MovieViewController()
        let nav2 = UINavigationController(rootViewController: movieVC)
        nav2.tabBarItem = UITabBarItem(title: "영화", image: UIImage(systemName: "person"), tag: 1)
        
        let nasaVC = NasaViewController()
        let nav3 = UINavigationController(rootViewController: nasaVC)
        nav3.tabBarItem = UITabBarItem(title: "나사", image: UIImage(systemName: "globe.central.south.asia.fill"), tag: 2)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }

    

}
