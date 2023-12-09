//
//  MainTabBarViewController.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 09.12.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: - Set up
private extension MainTabBarViewController {
    func setUp() {
        tabBar.tintColor = .label
        
        setViewControllers([homeVC(), upcomingVC(), searchVC(), downloadsVC()], animated: true)
    }
}

// MARK: - Creating controllers
private extension MainTabBarViewController {
    func homeVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.title = "Home"
        
        return homeVC
    }
    
    func upcomingVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: UpcomingViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "play.circle")
        homeVC.title = "Coming Soon"
        
        return homeVC
    }
    
    func searchVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: SearchViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        homeVC.title = "Top Search"
        
        return homeVC
    }
    
    func downloadsVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: DownloadsViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        homeVC.title = "Downloads"
        
        return homeVC
    }
}

