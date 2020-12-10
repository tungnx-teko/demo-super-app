//
//  UIView+Tracking.h
//  TekoTracker
//
//  Created by Dung Nguyen on 4/29/20.
//

#ifndef UIView_Tracking_h
#define UIView_Tracking_h

#import <UIKit/UIView.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIEvent.h>

@interface UIView (Tracking)

@property (nonatomic, retain, nullable) IBInspectable NSString *trackingContentName;
@property (nonatomic, retain, nullable) IBInspectable NSString *trackingRegionName;
@property (nonatomic, retain, nullable) IBInspectable NSString *trackingTarget;
@property (nonatomic) IBInspectable NSInteger trackingIndex;
@property (nonatomic, retain, nullable) id trackingPayload;

@property (nonatomic, readonly, getter=isReadyToTrack) BOOL readyToTrack;

@end

#endif /* UIView_Tracking_h */
