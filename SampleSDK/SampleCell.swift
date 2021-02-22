//
//  SampleCell.swift
//  SampleSDK
//
//  Created by Tung Nguyen on 2/19/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import UIKit
import TerraTheme

class SampleCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    override func reloadWithTheme(_ theme: Theme) {
        btnAction.backgroundColor = theme.primary?._200
    }
    
}
