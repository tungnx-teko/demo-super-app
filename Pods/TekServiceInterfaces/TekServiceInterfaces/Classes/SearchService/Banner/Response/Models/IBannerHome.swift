//
//	Document.swift


import Foundation

public protocol IBanner {
    var action: IBannerAction? { get }
    var campaignName: String? { get }
    var descriptionField: String? { get }
    var displayPage: String? { get }
    var endDate: Int? { get }
    var id: Int? { get }
    var image: String? { get }
    var isActive: Bool? { get }
    var priority: Int? { get }
    var saleCategoryCodes: String? { get }
    var saleCategoryIds: String? { get }
    var startDate: Int? { get }
    var terminals: [String] { get }
    var zone: String? { get }
    var targetPath: String? { get }
    var urlType: String? { get }
    var label: String? { get }
    var url: String? { get }
    var params: IBlockParams? { get }
        
}
