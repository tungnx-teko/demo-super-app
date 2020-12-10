//
//  TrackerController+EcommerceExtension.swift
//  TekoTracker
//
//  Created by Dung Nguyen on 2/25/20.
//

extension TrackerController {
    @objc(ecommerce_createScreenViewDataFromViewController:lastScreenViewName:navigationStart:loadEventEnd:)
    dynamic func ecommerce_createScreenViewData(fromViewController viewController: UIViewController, lastScreenViewName: String, navigationStart: TimeInterval, loadEventEnd: TimeInterval) -> ScreenViewEventData {
        guard let productViewTrackable = viewController as? ProductViewTrackable else {
            return ecommerce_createScreenViewData(
                fromViewController: viewController,
                lastScreenViewName: lastScreenViewName,
                navigationStart: navigationStart,
                loadEventEnd: loadEventEnd
            )
        }
        let viewControllerName = viewController.trackingName ?? ""
        return ProductViewEventData(screenName: viewControllerName,
                                    referrerScreenName: lastScreenViewName,
                                    sku: productViewTrackable.trackingSku,
                                    productName: productViewTrackable.trackingProductName,
                                    channel: productViewTrackable.trackingChannel,
                                    terminal: productViewTrackable.trackingTerminal,
                                    contentType: viewController.trackingContentType ?? "",
                                    title: viewController.trackingTitle,
                                    href: viewController.trackingHref,
                                    extra: nil,
                                    navigationStart: navigationStart,
                                    loadEventEnd: loadEventEnd)
    }
}
