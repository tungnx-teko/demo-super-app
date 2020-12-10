//
//  IListing.swift
//  Pods-TekServiceInterfaces_Tests
//
//  Created by linhvt on 9/7/20.
//

import Foundation

public protocol IListing {
    var products: [IProduct] { get }
    var filter: IFilter? { get }
    var pagination: IPagination? { get }
}
