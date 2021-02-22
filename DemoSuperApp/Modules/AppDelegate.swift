//
//  AppDelegate.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Terra
import Terra
import Hestia
import Janus
import TrackingBridge
import FirebaseCore
import TerraTheme
import SampleSDK

extension UIApplication {
    static var terraApp: ITerraApp!
}

var terraApp: ITerraApp {
    return UIApplication.terraApp
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.buildRootViewController()
        
        self.loadTerra(application: application, launchOptions: launchOptions) { [weak self] success in
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
            let nav = UINavigationController(rootViewController: homeVC)
            self?.window?.rootViewController = nav
        }
        return true
    }
    
    func buildRootViewController() {
        let vc = SplashViewController(nibName: "SplashViewController", bundle: Bundle(for: SplashViewController.self))
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
    
    func loadTerra(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?, completion: @escaping (Bool) -> ()) {
        TerraApp.configure(appName: "cyhome:ios", bundleId: "vn.teko.superapp.demo") { (isSuccess, terraApp) in
            if isSuccess {
                UIApplication.terraApp = terraApp
                
                SampleModule.configure(terraApp: terraApp)
                ThemeManager.shared.configure(appName: terraApp.identity, forBundle: Bundle(for: AppDelegate.self))
                ThemeManager.shared.configureTheme(theme: Theme.sample(), forApp: terraApp.identity)
                
                TerraHestia.configureWith(app: terraApp)
                TerraJanus.configureWith(app: terraApp, for: application, launchOptions: launchOptions)
                AppTrackingBridgeManager.initialize(withBridge: SuperAppTrackingBridge())
            }
            completion(isSuccess)
        }
    }

}
