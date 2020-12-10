//
//  IBannerService.swift
//  TekServiceInterfaces
//
//  Created by linhvt on 9/29/20.
//

import Foundation

public enum BannerZone {
    case home
    case landingPage
}

public typealias BannerResultHandler = (_ result: [IBanner], _ page: IPageResponse?, _ isSuccess: Bool, _ error: Error?) -> Void

public protocol IBannerService {
    func getBannerItems(with zone: BannerZone, campaignKey: String, completion: @escaping BannerResultHandler)
}
