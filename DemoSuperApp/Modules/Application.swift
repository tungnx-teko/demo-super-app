//
//  Application.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import UIKit
import Terra
import Hestia
import Janus

public var terraApp: ITerraApp = Application.shared.terraApp

class Application {
    static var shared = Application()
    
    var terraApp: ITerraApp!
    var window: UIWindow!
    var application: UIApplication!
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    func attachWindow(_ window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .black
    }
    
    func buildRootViewController() {
        let vc = SplashViewController(nibName: "SplashViewController", bundle: Bundle(for: SplashViewController.self))
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    func appDidFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.application = application
        self.launchOptions = launchOptions
        buildRootViewController()
    }
    
    
    func setupTekoTracking() {
//        Tracker.configureMock()
    }
}



extension Application {
    
    func loadTerra(completion: @escaping ((Bool) -> Void)) {
        TerraApp.configure(appName: "superappdemo:ios", bundleId: "vn.teko.ios.superapptemplate") { [weak self] (isSuccess, terraApp) in
            guard let self = self else { return }
            if isSuccess, let terraApp = terraApp {
                Application.shared.terraApp = terraApp
                TerraHestia.configureWith(app: terraApp)
                TerraJanus.configureWith(app: terraApp, for: self.application, launchOptions: self.launchOptions)
//                AppTrackingBridgeManager.initialize(withBridge: TrackingBridge())
            }
            completion(isSuccess)
        }
        
    }
    
}
