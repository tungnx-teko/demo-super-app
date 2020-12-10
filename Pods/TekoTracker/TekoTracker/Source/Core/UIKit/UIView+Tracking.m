//
//  UIView+Tracking.m
//  TekoTracker
//
//  Created by Dung Nguyen on 4/29/20.
//

#import "UIView+Tracking.h"
#import <objc/runtime.h>

@implementation UIView (Tracking)

- (NSString *)trackingContentName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingContentName:(NSString *)trackingContentName {
    objc_setAssociatedObject(self, @selector(trackingContentName), trackingContentName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackingRegionName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingRegionName:(NSString *)trackingRegionName {
    objc_setAssociatedObject(self, @selector(trackingRegionName), trackingRegionName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)trackingTarget {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingTarget:(NSString *)trackingTarget {
    objc_setAssociatedObject(self, @selector(trackingTarget), trackingTarget, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)trackingIndex {
    NSNumber *trackingIndex = objc_getAssociatedObject(self, _cmd);
    if (trackingIndex) {
        return [trackingIndex integerValue];
    }
    return [self tag];
}

- (void)setTrackingIndex:(NSInteger)trackingIndex {
    objc_setAssociatedObject(self, @selector(trackingIndex), [[NSNumber alloc] initWithInteger:trackingIndex], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)trackingPayload {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTrackingPayload:(id)trackingPayload {
    objc_setAssociatedObject(self, @selector(trackingPayload), trackingPayload, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isReadyToTrack {
    return [self trackingRegionName] && [self trackingContentName];
}

@end
