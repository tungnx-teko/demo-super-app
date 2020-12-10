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
//import TripiFlightKit
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
//        let params: [String: Any] = [
//            "caid": "20",
//            "isHideBottomBar": true,
//            "lang": "vi",
//            "buttonRadius": 4,
//            "accessToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjdjN2JlNTE0LTNiOWUtNDExYi1iZmYyLTQ2NGJhOTQ5ZGFmZSIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL29hdXRoLnN0YWdlLnRla29hcGlzLm5ldCIsImF1ZCI6InRyaXBpLWZsaWdodDo5Yjg2MzcxMC1mN2Y4LTExZWEtYWRjMS0wMjQyYWMxMjAwMDIiLCJpYXQiOjE2MDY3OTUzODIsImV4cCI6MTYwNjc5NTY4MiwiYXV0aF90aW1lIjoxNjA2Nzk1MzgyLCJzdWIiOiJkYWY0MzY1ODdkNWE0YTA3YTcwNGNjYzFlZWE1MDU5MiIsIm5hbWUiOiJIYWkgUGh1bmciLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDQuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1qLTVTNF92TS1OOC9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BTVp1dWNsZVQyMHRqc1doLW1BVHl5dWJDWUxmWmxyY013L3M5Ni1jL3Bob3RvLmpwZyIsImVtYWlsIjoiY3V0ZTExMDJAZ21haWwuY29tIiwicGhvbmVfbnVtYmVyIjoiMDkxNjg2ODIwMSIsImFkZHJlc3MiOm51bGwsImJpcnRoZGF5IjpudWxsfQ.LdcAU4Rb7oCEBGpMUodnz9hxoUDn8xXdM9QxRql7t7fyKL_yUPFrjgWPnmmKcmjEVAeW0-aB69ZiaTWwvSoH4nKFc_7rnPtLk9mqMiVjXYhQFXJLTTXbN3p2R0VnU6J7c65rpyLGpf1jQKZUF5KdVbH2_JdKa55WYeNQMUx8EqPz0KEuImpP9W061Dp_tQ16QQL9bOFTqcrqQpTSWdrAYpzc85e6TawXLMFWxhRr4eCtbHg3amaNBPJyBZ7OacAIwXC-0VKlV__r9hBMNGHmein_ceSVr9LibzAXDrQOsXb7rsgJ-6HakI50U-TSA_IQGCZL2__r1XkT8scGq6Sc5VEoX9tgd6FyjFf3wZ7wTONXfo4nORcwm0wcEifYUnysaCRhyFE2EKtl1ZbLZKkoEqSUQNJUIH0BJacYjiZ2wVlfPagpLUjChnJQJcvXYz0IJpSSJ8PGuSLYYMdUrOpzT1GEXtJobzklue2wLJfVlLAChoNEMeamkfJZZ2CD9iqejCvrq6xclQ8yY14FmSyuVT8_aPWLrkHU3m4vIS3ownBfbQy6GSBZFUyClR9YnLb2zMkv2DMBPuxwmrBBb3GAxAOA9vYM33PfzE3wiZO0YPcovVaDHp2c0ZRN2JMxAv0_PN52clSP5bXq3Y1r1LcWMcXe03B2diuVOjoJ7-owDyc",
//            "provider": "teko"
//        ]
//        TripiFlightKit.shared.callFlightSDK(params: params,
//                                            delegate: self) { [weak self] (error, vc) in
//                                                guard let sSelf = self else { return }
//                                                if let vc = vc {
//                                                    sSelf.navigationController?.pushViewController(vc, animated: true)
//                                                } else if let message = TripiFlightKit.shared.getMessage(error) {
//                                                    let alertVC = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
//                                                    alertVC.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler: nil))
//                                                    sSelf.present(alertVC, animated: true, completion: nil)
//
//                                                }
//        }
    
    }
    
    @IBAction func vnshopWasTapped(_ sender: Any) {
        openApp(appCode: "vnshop")
    }
    @IBAction func icheckLoginWasTapped(_ sender: Any) {
//        let sv = iCheck.TokenGenerateService(url: URL(string: "https://social.dev.icheck.vn")!)
        let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjBkNTdhMGJlLTNlZDItNDJhMi1iM2U1LTM2Y2E3ZjkzMjEyMjQifQ.eyJzdWIiOjExMjM2OCwibmFtZSI6IlR14bqlbiBOZ3V54buFbiIsImVtYWlsIjoidHVhbkBnbWFpbC5jb20iLCJwaG9uZV9udW1iZXIiOiIwOTg3NjYzOTY3IiwicGljdHVyZSI6Imh0dHBzOi8vYXNzZXRzLmljaGVjay52bi9tdWx0aXBhcnQvMjAyMC9hcHAwMS85LzhhN2IwY2Y4NjFhOGQ1YzgwYjQzZTUzMWFkNjljODM0LnBuZyIsImFkZHJlc3MiOiIzNjggQ-G6p3UgR2nhuqV5IiwiYmlydGhkYXkiOiIxMi8yLzIwMDAiLCJhdWQiOiJpY2hlY2siLCJpYXQiOjE2MDc0MjYzMjMsImV4cCI6MTYwNzU5OTEyMywiaXNzIjoibXlpc3N1ZXJuYW1lIn0.7dCRRxdzmnU9x8yayRt3h_hauwZxTP5drjo0AeNt3dvvlJOJeY3310BbsUgmUdZK7xyYajdJLsJAGYJ-9SKRuw"
//        sv.requestToGenerateToken { [weak self] (token) in
//            print("iCheck token: \(String(describing: token))")
//            guard let token = token else { return }
//            self?.login(withToken: token)
//        }
        self.login(withToken: token)
        
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

//extension ViewController: TripiFlightKitDelegate {
//    
//    func didBackFromSDK() {
//        
//    }
//    
//    func didBookOrderWith(jsonData: Data?) {
//        
//    }
//    
//}
