//
//  IntroPresenter.swift
//  Instgram
//
//  Created by ahlam on 24/12/2023.
//

import Foundation
import UIKit


protocol IntroPresenterProtocol {
    
    func viewDidLoad()
    func didPressedGoogle(in view: UIViewController)
    func disPressedFacebook(in view : UIViewController)
}

class IntroPresenter : NSObject {
    
    private var repo: AuthRepo
    private var delegate: IntroVCProtocol?
    
    
    init(delegate: IntroVCProtocol?) {
        self.delegate = delegate
        repo = AuthRepo()

    }
    
  
}


// MARK: - [View] -> [Presenter]

extension IntroPresenter: IntroPresenterProtocol {
   

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
