//
//  IStorage.swift
//  TekServiceInterfaces
//
//  Created by Nguyen An Bien on 10/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IStorage {
    var id: Int? { get }
    var originalName: String? { get }
    var replacementName: String? { get }
    var contentType: String? { get }
    var extensionType: String? { get }
    var url: String? { get }
}
