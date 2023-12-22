//
//  TabBarVC.swift
//  Instgram
//
//  Created by ahlam on 11/12/2023.
//

import Foundation


//
//  AppTabBarController.swift
//  Instagram
//
//  Created by Mohamed Elbana on 04/12/2023.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Home
        let itemHome = NavBarVC(
            rootViewController: HomeVC())
        
        let tabHome = UITabBarItem(
            title: "Home",
            image: UIImage(named: "ic_home"),
            selectedImage: UIImage(named: "ic_home"))
        
        itemHome.tabBarItem = tabHome
        
        // Profile
        let itemProfile = NavBarVC(
            rootViewController: ProfileVC())
        
        let tabProfile = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "ic_profile"),
            selectedImage: UIImage(named: "ic_profile"))
        
        itemProfile.tabBarItem = tabProfile
        
        viewControllers = [itemHome, itemProfile]
    }
}