//
//  MiniViewController.swift
//  Mini
//
//  Created by Tung Nguyen on 2/18/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import UIKit

public class MiniViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        if let clazz = label.findViewController()?.classForCoder {
            let bundle = Bundle(for: clazz)
            print("Mini app bundle id = \(bundle.bundleIdentifier ?? "")")
        }
    }

}

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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        navigationController?.navigationBar.endEditing(true)
    }
    
    
    
    func displayViewController(_ childVC: UIViewController, in view: UIView) {
        addChild(childVC)
        childVC.view.frame = view.bounds
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    func removeViewController(_ childVC: UIViewController) {
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
    
}
