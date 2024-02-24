//
//  AuthRepo.swift
//  Instgram
//
//  Created by ahlam on 26/01/2024.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FacebookLogin


class AuthRepo {
    
    private var databaseReference: DatabaseReference
   

    init() {
        databaseReference = Database.database().reference()
        setupGoogleAuth()
    }
    
    func setupGoogleAuth() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    
    func signInWithGoogle(in view: UIViewController, completed: @escaping () -> ()) {
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [unowned self] result, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("User or idToken null..")
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                print("Success!")
                
                let id = result?.user.uid ?? ""
                let profile = result?.additionalUserInfo?.profile
                let name = (profile?["name"] as? String) ?? ""
                let email = (profile?["email"] as? String) ?? ""
                let imageUrl = (profile?["picture"] as? String) ?? ""
                
                self.saveUserData(id: id,
                                  name: name,
                                  email: email,
                                  imageUrl: imageUrl , completed : completed)
            }
        }
    }
    
    func signInFacebook(in view: UIViewController , completed: @escaping () -> ()) {
        let loginManager = LoginManager()
       
        loginManager.logIn(permissions: ["public_profile", "email"], from: view) { [weak self] (result, error) in
            
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
                self?.saveUserData(id: profile?.userID ?? "", name: profile?.name ?? "", email: profile?.email ?? "", imageUrl: "\(profile?.imageURL)") {
                    completed()
                    print(profile)
                }
                        
            }
                  
        }
    }
    
    
    func saveUserData(id: String,
                      name: String,
                      email: String,
                      imageUrl: String,completed: @escaping () -> ()) {
        
        databaseReference.child("Users").child(id).observeSingleEvent(of: .value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            
            if value == nil {
                self.databaseReference.child("Users")
                    .child(id).setValue(
                        ["id": id,
                         "name": name,
                         "username": self.generateUsername(name),
                         "email": email,
                         "imageUrl": imageUrl])
            }
            completed()
            
        }) { error in
            print(error.localizedDescription)
        }
        
       
    }
    
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    private func generateUsername(_ name: String) -> String {
        let random = Int.random(in: 1000...9999)
        let username = name.replacingOccurrences(of: " ", with: "")
        return "\(username.lowercased())\(random)"
    }
    
    func getUser(completed: @escaping (NSDictionary?) -> ()) {
        
        let currentUser = Auth.auth().currentUser
        guard let uid = currentUser?.uid else { return }
        
        databaseReference.child("Users").child(uid).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            completed(value)
        }) { error in
            print(error.localizedDescription)
            completed(nil)
        }
    }
}



