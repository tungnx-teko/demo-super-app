//
//	PageResponse.swift


import Foundation

public protocol IPageResponse {
    var currentPage: Int? { get }
    var pageSize: Int? { get }
    var totalItems: Int { get }
    var totalPage: Int { get }
}
