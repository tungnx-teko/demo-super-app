//
//  IProductPromotion.swift
//  Pods
//
//  Created by Nguyen Xuan on 10/5/20.
//

import Foundation

public protocol IProductPromotion: IPromotion {
    var benefit: IProductBenefit? { get }
    var condition: IProductCondition? { get }
    var endTimestampSec: String? { get }
}
