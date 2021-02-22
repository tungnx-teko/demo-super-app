//
//  EventTypeProtocol.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/27/20.
//

#ifndef EventTypeProtocol_h
#define EventTypeProtocol_h

#import <Foundation/NSString.h>

@protocol EventTypeProtocol

@property (nonatomic, retain, nonnull, readonly) NSString *value;
@property (nonatomic, retain, nonnull, readonly) NSString *schemaIdentifier;

@end

#endif /* EventTypeProtocol_h */
