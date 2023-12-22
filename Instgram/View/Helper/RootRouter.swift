//
//  RootRouter.swift
//  Instgram
//
//  Created by ahlam on 11/12/2023.
//

import Foundation
import UIKit


class RootRouter {
    
    static func presentRootScreen(with root: UIViewController) {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        window?.makeKeyAndVisible()
        let navigation = NavBarVC(rootViewController: root)
          window?.rootViewController = navigation
    }
    
 
}
