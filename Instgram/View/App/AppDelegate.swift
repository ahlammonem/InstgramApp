//
//  AppDelegate.swift
//  Instgram
//
//  Created by ahlam on 08/12/2023.
//
import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookCore



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    FirebaseApp.configure()
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )

    return true
}
     
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let sourceApplication = options[.sourceApplication] as? String {
            // Check if the URL scheme is related to Google Sign-In
            if url.scheme == "com.googleusercontent.apps.623440679460-50odlkju1ed0ed5etla0umclvp1doslm" {
                return GIDSignIn.sharedInstance.handle(url)
            } else {
                // Handle other URL schemes here if needed
                ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: sourceApplication,
                    annotation: options[.annotation]
                )
            }
        }
        return false
    }





    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}


