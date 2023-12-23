//
//  NavBarVC.swift
//  Instgram
//
//  Created by ahlam on 11/12/2023.
//

import Foundation
import UIKit

class NavBarVC : UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
       
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        
       //setUpUI()
     }
     
     override func awakeFromNib() {
         super.awakeFromNib()
      //setUpUI()
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
     }
    
    
    private func setUpUI(){
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.font :UIFont.systemFont(ofSize: 22, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor.black ,
                                              
        ]
        
        //remove back text
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
         
        let backButtonAtrributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        BarButtonItemAppearance.setTitleTextAttributes(backButtonAtrributes, for: .normal)

        //change back icon color
        BarButtonItemAppearance.tintColor = .black
    }
    
   
    
}


