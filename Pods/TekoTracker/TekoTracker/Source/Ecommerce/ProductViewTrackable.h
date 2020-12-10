//
//  ProductViewTrackable.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/13/20.
//

#ifndef ProductViewTrackable_h
#define ProductViewTrackable_h

#import <Foundation/Foundation.h>

@protocol ProductViewTrackable

@property (nonatomic, retain, nonnull, readonly) NSString *trackingSku;
@property (nonatomic, retain, nonnull, readonly) NSString *trackingProductName;
@property (nonatomic, retain, nonnull, readonly) NSString *trackingChannel;
@property (nonatomic, retain, nonnull, readonly) NSString *trackingTerminal;

@end

#endif /* ProductViewTrackable_h */
