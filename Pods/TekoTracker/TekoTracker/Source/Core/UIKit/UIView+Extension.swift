//
//  UIView+Extension.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 6/16/20.
//

import UIKit

extension UIView {
    public var trackableViews: [UIView] { getTrackableSubviews(in: self) }

    public var visibleContentEventData: VisibleContentEventData {
        VisibleContentEventData(
            index: trackingIndex,
            regionName: trackingRegionName ?? "",
            contentName: trackingContentName ?? ""
        )
    }
}

func getTrackableSubviews(in view: UIView) -> [UIView] {
    if view is UIScrollView {
        let defaultTrackableViews = view.isReadyToTrack ? [view] : []
        switch view {
        case let tableView as UITableView:
            return defaultTrackableViews + tableView.visibleCells.flatMap { $0.trackableViews }
        case let collectionView as UICollectionView:
            return defaultTrackableViews + collectionView.visibleCells.flatMap { $0.trackableViews }
        default:
            return defaultTrackableViews
        }
    }
    guard view.isReadyToTrack else {
        return view.subviews.flatMap(getTrackableSubviews)
    }
    return [view] + view.subviews.flatMap(getTrackableSubviews)
}

func getScrollView(in view: UIView) -> [UIScrollView] {
    var result: [UIScrollView]
    if let scrollView = view as? UIScrollView {
        result = [scrollView]
    } else {
        result = []
    }
    return result + view.subviews.flatMap(getScrollView)
}
