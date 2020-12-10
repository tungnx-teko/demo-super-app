//
//  IDefinition.swift
//  PPMServiceInterface
//
//  Created by Tung Nguyen on 8/4/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

public protocol IDefinition: IPromotion {
    var benefit: IPPMBenefit? { get }
    var condition: IPPMCondition? { get }
    var sellerId: Int? { get }
    var type: String { get }
    var isPrivate: Bool { get }
    var partner: String? { get }
    var govRegister: Bool { get }
    var campaign: IPPMCampaign? { get }
    var startedAt: String? { get }
    var endedAt: String? { get }
    var timeRanges: [ITimeRange] { get }
}
