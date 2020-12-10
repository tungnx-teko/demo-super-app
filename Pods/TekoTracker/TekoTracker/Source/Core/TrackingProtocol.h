//
//  TrackingProtocol.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/27/20.
//

#ifndef TrackingProtocol_h
#define TrackingProtocol_h

#import "EventTypeProtocol.h"
#import "EventDataProtocol.h"

NS_SWIFT_NAME(ObjcTrackingProtocol)
@protocol TrackingProtocol

- (void)useForUserID:(nonnull NSString *)userID phoneNumber:(nullable NSString *)phoneNumber;
- (void)sendWithEventType: (nonnull id<EventTypeProtocol>)eventType eventName:(nonnull NSString*)eventName data:(nonnull id<EventDataProtocol>)data isImmediate:(BOOL)isImmediate;

@end

#endif /* TrackingProtocol_h */
