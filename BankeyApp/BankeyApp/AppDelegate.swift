//
//  AppDelegate.swift
//  BankeyApp
//
//  Created by Mykhailo Kotyk on 22.03.2024.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow (frame: UIScreen.main.bounds)
        window? .makeKeyAndVisible()
        window? .backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        let vc = mainViewController
        vc.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = appColor
        
        window?.rootViewController = vc

        return true
    }
}

//MARK: - LoginViewControllerDelegate


extension AppDelegate : LoginViewControllerDelegate {
    func didLogin() {
        print("DEBUG: did login")
        setRootViewController(LocalState.hasOnboarded ? mainViewController : onboardingContainerViewController)
    }
}

//MARK: - OnboardingContainerViewControllerDelegate
extension AppDelegate : OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("DEBUG: didFinishOnboarding")
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

//MARK: - add setRoot func
extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil)
        
    }
}
//MARK: - LogoutDelegate
extension AppDelegate : LogoutDelegate {
    func didLogout() {
        print("DEBUG: didFinishOnboarding")
        setRootViewController(loginViewController)
    }
}
