//
//  IntroVC.swift
//  Instgram
//
//  Created by ahlam on 08/12/2023.
//

import UIKit
import FacebookLogin


protocol IntroVCProtocol {
    func didSignedUser()
}

class IntroVC: NibVC {
  
   private var presenter: IntroPresenterProtocol?
  
    override init() {
        super.init()
        presenter = IntroPresenter(delegate: self)
    }
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        //self.createGoogleSignInConfig()
    }
    
    
    //MARK: BUTTONS CLICKS
    @IBAction private func signUpButtonDidPressed(_ sender: UIButton) {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction private func loginWithFaceBookButtonDidPressed(_ sender: UIButton) {
        
        let loginManager = LoginManager()
       
      
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { [weak self] (result, error) in
            
            // Check for error
            guard error == nil else {
                // Error occurred
                print(error!.localizedDescription)
                return
            }
            
            // Check for cancel
            guard let result = result, !result.isCancelled else {
                print("User cancelled login")
                return
            }
            
            Profile.loadCurrentProfile { (profile, error) in
                         print(profile)
            }
                  
        }
    }
    
    
    @IBAction private func loginWithGoogleDidPressed(_ sender: UIButton){
        presenter?.didPressedGoogle(in: self)
    }
    
    
    
    private func presentHome() {
        let tabBar = TabBarVC()
        RootRouter.presentRootScreen(with: tabBar)
     }
    
    
}


// MARK: - [Presenter] -> [View]

extension IntroVC: IntroVCProtocol {
    
    func didSignedUser() {
        presentHome()
    }
}
