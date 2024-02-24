//
//  SignUpVC.swift
//  Instgram
//
//  Created by ahlam on 22/12/2023.
//

import UIKit


protocol SignUpVCProtocol {
    func didSignedUser()
}

class SignUpVC: NibVC {
    
    private var presenter: SignUpPresenterProtocol?
    
      override init() {
          super.init()
          presenter = SignUpPresenter(delegate: self)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign Up"
       
        
    }
    
  

    @IBAction private func loginWithFaceBookButtonDidPressed(_ sender: UIButton) {
        
        presenter?.disPressedFacebook(in: self)
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

extension SignUpVC: SignUpVCProtocol {
    
    func didSignedUser() {
        presentHome()
    }
}
