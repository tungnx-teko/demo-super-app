//
//  TrackerController+Internal.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/25/20.
//

#ifndef TrackerController_Internal_h
#define TrackerController_Internal_h

#import <UIKit/UIKit.h>
#import <TekoTracker/TekoTracker-Swift.h>

SWIFT_CLASS("ObjcTrackerController")
@interface TrackerController : NSObject

- (nonnull ScreenViewEventData *)createScreenViewDataFromViewController: (nonnull UIViewController *)viewController lastScreenViewName: (nonnull NSString *)lastScreenViewName navigationStart:(NSTimeInterval)navigationStart loadEventEnd:(NSTimeInterval)loadEventEnd;
- (nonnull ScreenViewEventData *)ecommerce_createScreenViewDataFromViewController: (nonnull UIViewController *)viewController lastScreenViewName: (nonnull NSString *)lastScreenViewName navigationStart:(NSTimeInterval)navigationStart loadEventEnd:(NSTimeInterval)loadEventEnd;

@end

#endif /* TrackerController_Internal_h */
