//
//  IDetail.swift
//  VNShop
//
//  Created by Nguyen Xuan on 9/2/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public protocol IDetail {
    var description: String? { get }
    var shortDescription: String? { get }
    var attributeSet: IAttributeSet? { get }
    var productLine: IProductLine? { get }
    var seoInfo: ISeoInfo? { get }
    var attributeGroups: [IAttributeGroup] { get }
    var images: [IProductImage] { get }
    var productGroup: IProductGroup? { get }
}
