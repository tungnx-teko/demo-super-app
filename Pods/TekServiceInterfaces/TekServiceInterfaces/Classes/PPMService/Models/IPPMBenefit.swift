//
//  IPPMBenefit.swift
//  Pods
//
//  Created by Nguyen Xuan on 10/5/20.
//

import Foundation

public protocol IPPMBenefit: IBenefit {
    var gifts: [IPPMItem] { get }
}
