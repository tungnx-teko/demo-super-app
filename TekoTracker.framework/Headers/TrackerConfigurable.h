//
//  TrackerConfigurable.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/13/20.
//

#ifndef TrackerConfigurable_h
#define TrackerConfigurable_h

#import <Foundation/Foundation.h>

@protocol TrackerConfigurable

@property (nonatomic, retain, nonnull, readonly) NSString *appID;
@property (nonatomic, retain, nonnull, readonly) NSString *schemaVersion;
@property (nonatomic, retain, nonnull, readonly) NSString *logServerURL;
@property (nonatomic, retain, nonnull, readonly) NSString *environment;
@property (nonatomic, readonly) BOOL manuallyLogViewController;
@property (nonatomic, readonly) int retryWhenFailed;
@property (nonatomic, readonly) BOOL scheduleRetryFailure;
@property (nonatomic, readonly) BOOL logDebug;
@property (nonatomic, retain, nonnull, readonly) NSArray<NSString *> *manuallyLogTrackingNames;
@property (nonatomic, retain, nonnull, readonly) NSArray<NSString *> *blacklistURL;
@property (nonatomic, retain, nonnull, readonly) NSArray<NSString *> *whitelistURL;
@property (nonatomic, retain, nonnull, readonly) NSArray *blacklistHttpCode;

@end

#endif /* TrackerConfigurable_h */
