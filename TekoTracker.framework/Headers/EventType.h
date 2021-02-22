//
//  EventType.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/28/20.
//

#ifndef EventType_h
#define EventType_h

#import <Foundation/NSObject.h>
#import "EventTypeProtocol.h"

NS_SWIFT_UNAVAILABLE("Use Swifty EventType instead")
@interface EventType : NSObject<EventTypeProtocol>

@property (nonatomic, class, readonly) id _Nonnull alert;
@property (nonatomic, class, readonly) id _Nonnull custom;
@property (nonatomic, class, readonly) id _Nonnull error;
@property (nonatomic, class, readonly) id _Nonnull interaction;
@property (nonatomic, class, readonly) id _Nonnull performanceTiming;
@property (nonatomic, class, readonly) id _Nonnull screenView;
@property (nonatomic, class, readonly) id _Nonnull timing;
@property (nonatomic, class, readonly) id _Nonnull visibleContent;

- (nonnull instancetype)initWithValue: (nonnull NSString *)value schemaIdentifier: (nonnull NSString *)schemaIdentifier;

@end

#endif /* EventType_h */
