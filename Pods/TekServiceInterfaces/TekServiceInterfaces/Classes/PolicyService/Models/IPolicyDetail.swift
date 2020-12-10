//
//  IDetailPolicy.swift
//  VNShop
//
//  Created by Dung Nguyen on 10/5/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IPolicyDetail {
    var id: Int { get }
    var name: String? { get }
    var iconURL: URL? { get }
}
