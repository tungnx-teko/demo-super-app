//
//  AlertTrackable.h
//  TekoTracker
//
//  Created by Dung Nguyen on 5/21/20.
//

#ifndef AlertTrackable_h
#define AlertTrackable_h

#import <Foundation/NSString.h>

@protocol AlertTrackable

@property (nonatomic, retain, nullable) NSString *trackingAlertType;
@property (nonatomic, retain, nullable) NSString *trackingAlertMessage;

@end

#endif /* AlertTrackable_h */
