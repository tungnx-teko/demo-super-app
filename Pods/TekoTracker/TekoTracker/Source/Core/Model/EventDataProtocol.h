//
//  EventDataProtocol.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/20/20.
//

#ifndef EventDataProtocol_h
#define EventDataProtocol_h

#import <Foundation/NSData.h>
#import <Foundation/NSError.h>
#import <Foundation/NSObject.h>

@protocol EventDataProtocol <NSObject>

- (nonnull NSData *) asData: (NSError *__autoreleasing * _Nonnull)error
__attribute__((swift_error(nonnull_error)));

@end

#endif /* EventDataProtocol_h */
