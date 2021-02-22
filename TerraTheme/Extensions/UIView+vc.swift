//
//  UIView+vc.swift
//  TerraTheme
//
//  Created by Tung Nguyen on 2/18/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
}
