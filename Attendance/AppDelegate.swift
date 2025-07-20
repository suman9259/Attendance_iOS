//
//  AppDelegate.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            UIWindow.appearance().overrideUserInterfaceStyle = .light
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
//    func showLoginScreen() {
//        let story = UIStoryboard(name: StoryBoardConstants.kMain, bundle:nil)
//        guard let vc = story.instantiateViewController(withIdentifier: LoginSignUpVC.id()) as? LoginSignUpVC else {
//            return
//        }
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.windows.first?.rootViewController = navigationController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
}
