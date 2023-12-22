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
import FirebaseDatabase

class IntroVC: NibVC {
    
  
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createGoogleSignInConfig()
    }
    
    
    //MARK: BUTTONS CLICKS
    @IBAction private func signUpButtonDidPressed(_ sender: UIButton) {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction private func loginWithFaceBookButtonDidPressed(_ sender: UIButton) {
        self.presentHome()
    }
    
    @IBAction private func loginWithGoogleDidPressed(_ sender: UIButton){
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
            
            
            
            Auth.auth().signIn(with: credential) { result, error in
               
                guard let result = result  else {return}
                print(result)
                let id        = result.user.uid
                let profile   = result.additionalUserInfo?.profile
                let name      = profile?["name"] as? String ?? ""
                let email     =  profile?["email"] as? String ?? ""
                let imageUrl  = result.user.photoURL?.absoluteString ?? ""
               
                self.saveUserData(id: id, name: name , email:  email, imageUrl: imageUrl)
            }
            
        }
    }
    
    
    private func saveUserData(id: String , name: String , email:String, imageUrl: String?){
        
        let ref = Database.database().reference()
        ref.child("Users").child(id).setValue(
            ["id":id,
             "name":name,
             "email":email,
             "imageUrl" : imageUrl
            ])
        
    }
    
    
}
