//
//  SampleListViewController.swift
//  SampleSDK
//
//  Created by Tung Nguyen on 2/19/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import UIKit
import TerraTheme
import TerraInstancesManager

extension UIViewController {
    
    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            if UIDevice.current.userInterfaceIdiom == .pad {
                let nibName = String.init(format: "%@_iPad", String(describing: T.self))
                if Bundle(for: T.self).path(forResource: nibName, ofType: "nib") != nil {
                    return T.init(nibName: nibName, bundle: Bundle(for: T.self))
                }
            }
            return T.init(nibName: String(describing: T.self), bundle: Bundle(for: T.self))
        }
        return instantiateFromNib(self)
    }
}

public class SampleModule {
    
    static var terraApp: ITerraApp!
    
    public static func configure(terraApp: ITerraApp) {
        SampleModule.terraApp = terraApp
        ThemeManager.shared.configure(appName: terraApp.identity, forBundle: Bundle(for: SampleModule.self))
    }
    
    public static func create() -> UIViewController {
        return SampleListViewController.instantiateFromNib()
    }
    
}

class SampleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goButton: UIButton!
    
    static var random = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SampleCell", bundle: Bundle(for: SampleCell.self)),
                           forCellReuseIdentifier: "SampleCell")
    }

    override open func reloadWithTheme(_ theme: Theme) {
        super.reloadWithTheme(theme)
        
        goButton.backgroundColor = theme.primary?._50
    }
    
    @IBAction func changeColorWasTapped(_ sender: Any) {
        if SampleListViewController.random % 2 == 0 {
            ThemeManager.shared.configureTheme(theme: Theme.sample(), forApp: SampleModule.terraApp.identity)
        } else {
            ThemeManager.shared.configureTheme(theme: Theme.sample2(), forApp: SampleModule.terraApp.identity)
        }
        SampleListViewController.random += 1
        
    }
    
    
}

extension SampleListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell") as! SampleCell
        cell.lblTitle.text = "#\(indexPath.row)"
        return cell
    }
    
}
