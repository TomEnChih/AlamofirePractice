//
//  TabBarVC.swift
//  AlamofireExample
//
//  Created by 董恩志 on 2021/6/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        let vc = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        let postVC = PostVC()
        let navPostVC = UINavigationController(rootViewController: postVC)

        let deleteVC = DeleteVC()
        let navDeleteVC = UINavigationController(rootViewController: deleteVC)
        
        let putVC = PutVC()
        
        navVC.tabBarItem.title = "Get"
        
        navPostVC.tabBarItem.title = "Post"
        
        navDeleteVC.tabBarItem.title = "Delete"
        
        putVC.tabBarItem.title = "Put"
        
        self.viewControllers = [navVC,navPostVC,navDeleteVC,putVC]
    }
    

}
