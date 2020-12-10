//
//  ViewController.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import UIKit
import Hestia
import Janus
import Terra

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func tripiWasTapped(_ sender: Any) {
        openApp(appCode: "tripi_flight")
    }
    
    @IBAction func vnshopWasTapped(_ sender: Any) {
        openApp(appCode: "vnshop")
    }
    @IBAction func icheckLoginWasTapped(_ sender: Any) {
        let sv = iCheck.TokenGenerateService(url: URL(string: "https://social.dev.icheck.vn")!)
        sv.requestToGenerateToken { [weak self] (token) in
            print("iCheck token: \(String(describing: token))")
            guard let token = token else { return }
            self?.login(withToken: token)
        }
    }
    
    func login(withToken token: String) {
        guard let loginManager = TerraLoginManager.getInstances(by: terraApp) else { return }
        do {
            try loginManager.login(credential: CustomAuthenticatorCredential(idToken: token), delegate: nil)
        } catch {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
}

extension ViewController {
    
    func openApp(appCode: String) {
        guard let hestia = TerraHestia.getInstance(by: terraApp) else {
            showAlert(title: "Error", message: "No intances of Hestia competitive with \(terraApp.identity)")
            return
        }
        hestia.startApp(onViewController: self, appCode: appCode, onSuccess: {
            print("Open \(appCode) successfully")
        }) {  [weak self] error in
            switch error {
            case .exchangeTokenFailed:
                self?.showAlert(title: "Error", message: "Invalid credentials. Please login")
            default:
                self?.showAlert(title: "Error", message: error.rawValue)
            }
        }
    }
    
}

extension ViewController: JanusLoginDelegate {
    
    func janusWillGetAuthCredential() {
        
    }
    
    func janusHasLoginSuccess(authCredential: JanusAuthCredential) {
        print("AccessToken IAM: \(authCredential.accessToken!)")
        showAlert(title: "Login successfully", message: authCredential.accessToken!)
    }
    
    func janusHasLoginFail(error: JanusError?) {
        
    }
    
}
