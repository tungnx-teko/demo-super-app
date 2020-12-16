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
    
    @IBAction func cyhomeLoginWasTapped(_ sender: Any) {
        self.login(withToken: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImNhOTdhOTRlLTMyN2YtNDY0ZC1hZWU0LTQyMDQ3NmE3OGRiYSJ9.eyJpc3MiOiJjeWhvbWVpc3N1ZXIiLCJzdWIiOjgxOTIsImlhdCI6MTYzOTAyODc0OCwiZXhwIjoxNjM5MDI4NzQ4LCJwaG9uZV9udW1iZXIiOiIrODQ4ODg2ODI2OTYiLCJhdWQiOiJjeWhvbWUifQ.pNA0ACU9hrFsWr6Q9nLRBDfzdBAAtAccAK2nsrbQpQMCQB38VajxkEIVZy0Cb5aUR_UFLntRrxMjrA6wf6Ae3h4NSYhgGUUJY8Hn_3AALhyUiY8uv7Jscf13kDXcrGoEq0shacHbfTs9CNpEXQ6-9mRLRrxRbc63uEE9vXS6qyFtpXhTdzY38QJZHt_P1s28LfsXvqMs8lRJx6qMo60Xxa_oOaL3UB-DCC8jMHoyvfpr4a_98r3CZwwvnRbs0Qsxpst-UIUa8OOm_FCkjhQ_o7_bKURI7luKi-qjvlsqdw_DupAOab_O59sEdRzn7iTmrRffV-pbnaeywPXkhgFZ99v_hX97ga6_N-QDzk45utWlOUruQxVI8MaO7nPnmPtQC-ZVpYyutWk7EDo5SshZRjchcl_fl16SLPsV_Xj2OspvVNQGp4C40JQxZHUukK7GTV1fkONfGxdED7sUh6iC98qPyWa6PqQXGh94wN8ZT2707a8Ysuc1tjaOXFhTFvyhnx7tAOds319D3dvPWiMnih5RPTXxTwzC5TkSaw3BbfFttMDoiDCNf6931rTI3CH6mkZPQgsn5hYk60nwE90IRoMYiMH5czTX2V3pM7Yx16NZQREnxr42fkoFlGCGe6IpyNZMjSH_tyJyLnIA7HQKMxK6XdjVsjyzZTNRDxjnIfo")
    }
    
    func login(withToken token: String) {
        let loginManager = TerraLoginManager.getInstances(by: terraApp)
        let credential = CustomAuthenticatorCredential(idToken: token)
        do {
            try loginManager?.login(credential: credential, delegate: self)
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
        showAlert(title: "Thông báo", message: "Đăng nhập IAM thành công")
    }
    
    func janusHasLoginFail(error: JanusError?) {
        
    }
    
}
