//
//  UIAlertController+Tracking.h
//  TekoTracker
//
//  Created by Dung Nguyen on 5/21/20.
//

#ifndef UIAlertController_Tracking_h
#define UIAlertController_Tracking_h

#import <UIKit/UIAlertController.h>
#import "AlertTrackable.h"

@interface UIAlertController (Tracking) <AlertTrackable>

@property (nonatomic) BOOL shouldTrackAsAlert;

@end

#endif /* UIAlertController_Tracking_h */
