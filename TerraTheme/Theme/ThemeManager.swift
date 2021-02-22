//
//  ThemeManager.swift
//  TerraTheme
//
//  Created by Tung Nguyen on 2/18/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import Foundation
import UIKit

public class ThemeManager {
    
    public static let shared = ThemeManager()
    
    // TerraApp_appName: Theme
    public var themes: [String: Theme] = [:]
    
    // bundleId -> terraApp
    public var bundles: [String: String] = [:]
    
    init() {
        UIViewController.swizzleViewDidLoad()
        UIViewController.swizzleViewWillDisappear()
        UITableViewCell.swizzleAwakeFromNib()
    }
    
    public func getTheme(forBundle bundleIdentifier: String) -> Theme? {
        return themes[bundleIdentifier]
    }
    
    public func configureTheme(theme: Theme, forApp appName: String) {
        theme.appName = appName
        themes[appName] = theme
        NotificationCenter.default.post(Notification(name: .themeUpdated,
                                                     object: nil,
                                                     userInfo: ["theme": theme]))
    }
    
    public func configure(appName: String, forBundle bundle: Bundle) {
        if let bundleId = bundle.bundleIdentifier {
            bundles[bundleId] = appName
        }
    }
    
    public func getTheme(forView view: UIView) -> Theme? {
        guard let clazz = view.findViewController()?.classForCoder,
              let bundleId = Bundle(for: clazz).bundleIdentifier else { return nil }
        return themes[bundleId]
    }
    
    public func getTheme(forViewController viewController: UIViewController) -> Theme? {
        guard let bundleId = Bundle(for: viewController.classForCoder).bundleIdentifier,
              let appName = bundles[bundleId] else { return nil }
        return themes[appName]
    }
    
    // Swizzle UIViewController viewDidLoad subscribe to ThemeUpdated event
    // if theme with bundleid == viewcontroller bundle id
    // then call apply theme
    
}
