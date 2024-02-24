//
//  SignUpPresenter.swift
//  Instgram
//
//  Created by ahlam on 26/01/2024.
//

import Foundation
import UIKit


protocol SignUpPresenterProtocol {
    
    func viewDidLoad()
    func didPressedGoogle(in view: UIViewController)
    func disPressedFacebook(in view : UIViewController)

}

class SignUpPresenter : NSObject {
    
    private var repo: AuthRepo
    private var delegate: SignUpVCProtocol?
    
    
    init(delegate: SignUpVCProtocol?) {
        self.delegate = delegate
        repo = AuthRepo()

    }
    
  
}


// MARK: - [View] -> [Presenter]

extension SignUpPresenter: SignUpPresenterProtocol {
    
    func viewDidLoad() {
        repo.setupGoogleAuth()
    }
    
    func didPressedGoogle(in view: UIViewController) {
        repo.signInWithGoogle(in: view, completed:{
            self.delegate?.didSignedUser()
        })
    }
    
    func disPressedFacebook(in view: UIViewController) {
        repo.signInFacebook(in: view) {
            self.delegate?.didSignedUser()
        }
    }
  
}
