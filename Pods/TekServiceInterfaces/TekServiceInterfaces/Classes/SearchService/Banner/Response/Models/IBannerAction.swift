//
//	Action.swift

import Foundation

public protocol IBannerAction {
    var extra : [IBannerExtra] { get }
    var target : String? { get }
    var trigger : String? { get }
    var type : String? { get }
    
}
