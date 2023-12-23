//
//  SplashVC.swift
//  Instgram
//
//  Created by ahlam on 08/12/2023.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                 self.presentIntro()
             }
    }
    
    private func presentHome() {
        
        let tabBar = TabBarVC()
        RootRouter.presentRootScreen(with: tabBar)
     }
    
    
    private func presentIntro(){
        let vc = IntroVC()
        RootRouter.presentRootScreen(with: vc)
    }


  
}
