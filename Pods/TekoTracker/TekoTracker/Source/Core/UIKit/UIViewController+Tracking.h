//
//  UIViewController+Tracking.h
//  TekoTracker
//
//  Created by Dung Nguyen on 1/15/20.
//

#ifndef UIViewController_Tracking_h
#define UIViewController_Tracking_h

#import <UIKit/UIViewController.h>

@interface UIViewController (Tracking)

@property (nonatomic, retain, nullable) IBInspectable NSString *trackingName;
@property (nonatomic, retain, nullable) IBInspectable NSString *trackingContentType;
@property (nonatomic, retain, nullable) IBInspectable NSString *trackingTitle;
@property (nonatomic, retain, nullable) NSString *trackingHref;
@property (nonatomic) IBInspectable BOOL shouldHoldToTrackOnLoad;

@property (nonatomic, readonly, getter=isReadyToTrack) BOOL readyToTrack;

@end

#endif /* UIViewController_Tracking_h */
