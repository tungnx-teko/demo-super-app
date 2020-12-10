//
//  IItem.swift
//  PPMServiceInterface
//
//  Created by Tung Nguyen on 8/4/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public protocol IItem {
    var sku: String { get }
    var name: String { get }
    var quantity: Int { get }
    var maxQuantityPerOrder: Int? { get }
}

public protocol IProductItem: IItem {
    var imageUrl: String? { get }
}

public protocol IPPMItem: IItem {
    var id: Int { get }
    var budgetId: Int { get }
    var budgetStatus: String { get }
    var outOfBudget: Bool { get }
}
