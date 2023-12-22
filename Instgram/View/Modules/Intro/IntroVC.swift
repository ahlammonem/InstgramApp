//
//  IntroVC.swift
//  Instgram
//
//  Created by ahlam on 08/12/2023.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class IntroVC: NibVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createGoogleSignInConfig()
    }
    
    
    
    @IBAction private func signUpButtonDidPressed(_ sender: UIButton) {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction private func loginWithFaceBookButtonDidPressed(_ sender: UIButton) {
        self.presentHome()
    }
    
    @IBAction private func loginWithGoogleDidPressed(_ sender: UIButton) {
        
        self.signInWithGoogle()
        
    }
    
    
    
    private func presentHome() {
        let tabBar = TabBarVC()
        RootRouter.presentRootScreen(with: tabBar)
     }
    
    private func createGoogleSignInConfig(){
        // Create Google Sign In configuration object.
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
       
    }
    
    private func signInWithGoogle(){
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {return}

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString else {return}

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
        }
    }
    
    
}
