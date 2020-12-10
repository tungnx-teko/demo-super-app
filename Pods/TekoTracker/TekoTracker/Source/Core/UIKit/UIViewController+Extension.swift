//
//  UIViewController+Extension.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 6/11/20.
//

import UIKit

extension UIViewController {
    public var visibleContentEventDataInView: [VisibleContentEventData] {
        getScrollView(in: view)
            .flatMap ({
                scrollView -> [VisibleContentEventData] in
                switch scrollView {
                case let tableView as UITableView:
                    return tableView.visibleCells
                        .flatMap { $0.trackableViews }
                        .map { $0.visibleContentEventData }
                case let collectionView as UICollectionView:
                    return collectionView.visibleCells
                        .flatMap { $0.trackableViews }
                        .map { $0.visibleContentEventData }
                default:
                    return []
                }
            })
    }
}
