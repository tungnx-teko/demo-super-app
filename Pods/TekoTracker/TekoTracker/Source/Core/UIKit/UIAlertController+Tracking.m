//
//  UIAlertController+Tracking.m
//  TekoTracker
//
//  Created by Dung Nguyen on 5/21/20.
//

#import "UIAlertController+Tracking.h"
#import <objc/runtime.h>

@implementation UIAlertController (Tracking)

- (NSString *)trackingAlertType {
    return @"alertDialog";
}

- (void)setTrackingAlertType:(NSString *)trackingAlertType {}

- (NSString *)trackingAlertMessage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingAlertMessage:(NSString *)trackingAlertMessage {
    objc_setAssociatedObject(self, @selector(trackingAlertMessage), trackingAlertMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldTrackAsAlert {
    NSNumber *numb = objc_getAssociatedObject(self, _cmd);
    if (numb) {
        return [numb boolValue];
    }
    return NO;
}

- (void)setShouldTrackAsAlert:(BOOL)shouldTrackAsAlert {
    NSNumber *numb = [NSNumber numberWithBool:shouldTrackAsAlert];
    objc_setAssociatedObject(self, @selector(shouldTrackAsAlert), numb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
