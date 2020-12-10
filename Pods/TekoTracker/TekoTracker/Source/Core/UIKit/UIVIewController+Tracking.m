//
//  UIVIewControllerTracking.m
//  TekoTracker
//
//  Created by Dung Nguyen on 1/15/20.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

- (NSString *)trackingName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingName:(NSString *)trackingName {
    objc_setAssociatedObject(self, @selector(trackingName), trackingName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackingContentType {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingContentType:(NSString *)trackingContentType {
    objc_setAssociatedObject(self, @selector(trackingContentType), trackingContentType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackingTitle {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingTitle:(NSString *)trackingTitle {
    objc_setAssociatedObject(self, @selector(trackingTitle), trackingTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackingHref {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingHref:(NSString *)trackingHref {
    objc_setAssociatedObject(self, @selector(trackingHref), trackingHref, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldHoldToTrackOnLoad:(BOOL)shouldHoldToTrackOnLoad {
    NSNumber *_shouldHoldToTrackOnLoad = [[NSNumber alloc] initWithBool:shouldHoldToTrackOnLoad];
    objc_setAssociatedObject(self, @selector(shouldHoldToTrackOnLoad), _shouldHoldToTrackOnLoad, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldHoldToTrackOnLoad {
    NSNumber *shouldHoldToTrackOnLoad = objc_getAssociatedObject(self, _cmd);
    return [shouldHoldToTrackOnLoad boolValue];
}

- (BOOL)isReadyToTrack {
    return [self trackingName] && YES;
}

@end
