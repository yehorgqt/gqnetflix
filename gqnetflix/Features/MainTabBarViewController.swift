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
        tabBar.tintColor = .systemRed
        
        setViewControllers([homeVC(), upcomingVC(), searchVC(), downloadsVC()], animated: true)
    }
}

// MARK: - Creating controllers
private extension MainTabBarViewController {
    func homeVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: Symbols.house())
        homeVC.title = "Home"
        
        return homeVC
    }
    
    func upcomingVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: UpcomingViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: Symbols.upcoming())
        homeVC.title = "Coming Soon"
        
        return homeVC
    }
    
    func searchVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: TopSearchViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: Symbols.search())
        homeVC.title = "Top Search"
        
        return homeVC
    }
    
    func downloadsVC() -> UINavigationController {
        let homeVC = UINavigationController(rootViewController: DownloadsViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: Symbols.downloads())
        homeVC.title = "Downloads"
        
        return homeVC
    }
}

