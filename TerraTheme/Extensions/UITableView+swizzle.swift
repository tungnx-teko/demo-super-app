//
//  UITableView+swizzle.swift
//  TerraTheme
//
//  Created by Tung Nguyen on 2/22/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func swizzleMethod(originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)!
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    static func swizzleAwakeFromNib() {
        let originalSelector = #selector(UITableViewCell.awakeFromNib)
        let swizzledSelector = #selector(UITableViewCell.theme_awakeFromNib)
        
        swizzleMethod(originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }
    
    @objc func theme_awakeFromNib() {
        self.theme_awakeFromNib()
        if let theme = getTheme() {
            reloadWithTheme(theme)
        }
        print(#function)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(themeUpdated),
                                               name: NSNotification.Name.themeUpdated,
                                               object: nil)
    }
    
    func unsubscribeTheme() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.themeUpdated,
                                                  object: nil)

    }
    
    @objc private func themeUpdated(notification: Notification) {
        guard let theme = notification.userInfo?["theme"] as? Theme else { return }
        guard let bundeId = Bundle(for: classForCoder).bundleIdentifier else { return }
        
        if theme.appName == ThemeManager.shared.bundles[bundeId] {
            themeDidUpdate(theme: theme)
        }
    }
    
    private func getTheme() -> Theme? {
        guard let bundeId = Bundle(for: classForCoder).bundleIdentifier else { return nil }
        guard let appName = ThemeManager.shared.bundles[bundeId] else { return nil }
        return ThemeManager.shared.themes[appName]
    }
    
    @objc func themeDidUpdate(theme: Theme) {
        reloadWithTheme(theme)
    }
    
    @objc open func reloadWithTheme(_ theme: Theme) {
        
    }
    
}
