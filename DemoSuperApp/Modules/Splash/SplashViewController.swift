//
//  SplashViewController.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        
        Application.shared.loadTerra { [weak self] (isSuccess) in
            if isSuccess {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
                self?.navigationController?.pushViewController(homeVC, animated: false)
            } else {

            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
