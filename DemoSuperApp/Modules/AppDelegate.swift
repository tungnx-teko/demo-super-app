//
//  AppDelegate.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.attachWindow(window!)
        Application.shared.appDidFinishLaunchingWithOptions(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

}
