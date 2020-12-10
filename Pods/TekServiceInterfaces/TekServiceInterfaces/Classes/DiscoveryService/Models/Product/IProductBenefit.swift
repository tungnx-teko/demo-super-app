//
//  IProductBenefit.swift
//  Pods
//
//  Created by Nguyen Xuan on 10/5/20.
//

import Foundation

public protocol IProductBenefit: IBenefit {
    var gifts: [IProductItem] { get }
}
