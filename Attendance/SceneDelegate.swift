//
//  SceneDelegate.swift
//  Attendance
//
//  Created by CodeAegis's Macbook Pro i9 on 09/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setSplashVC()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(showLogoutAlert(_:)), name: Notification.Name.kShowLogoutAlert, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(showSessionExpiredAlert(_:)), name: Notification.Name.kSessionExpiredAlert, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(showNetworkFailureAlert(_:)), name: Notification.Name.kNetworkFailure, object: nil)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
    
    func setSplashVC() {
        let story = UIStoryboard(name: StoryBoardConstants.kMain, bundle:nil)
        guard let vc = story.instantiateViewController(withIdentifier: SplashVC.id()) as? SplashVC else { return }
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    @objc func showNetworkFailureAlert(_ notification: Notification) {
//        
//        DispatchQueue.main.async {
//            if let topVC = self.topMostViewController() {
//                let alert = UIAlertController(title: AlertConstants.kAppName, message: AlertConstants.kNoInternet, preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
//                }
//                alert.addAction(okAction)
//                topVC.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
//    
//    func topMostViewController() -> UIViewController? {
//        guard let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
//            return nil
//        }
//        return getTopViewController(rootVC)
//    }
//    
//    private func getTopViewController(_ vc: UIViewController) -> UIViewController {
//        if let presentedVC = vc.presentedViewController {
//            return getTopViewController(presentedVC)
//        } else if let navVC = vc as? UINavigationController, let visibleVC = navVC.visibleViewController {
//            return getTopViewController(visibleVC)
//        } else if let tabVC = vc as? UITabBarController, let selectedVC = tabVC.selectedViewController {
//            return getTopViewController(selectedVC)
//        } else {
//            return vc
//        }
//    }
}
