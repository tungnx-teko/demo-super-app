//
//  EventType+Ecommerce.h
//  TekoTracker
//
//  Created by Dung Nguyen on 2/28/20.
//

#ifndef EventType_Ecommerce_h
#define EventType_Ecommerce_h

#import "EventType.h"

@interface EventType (Ecommerce)

@property (nonatomic, class, readonly) id _Nonnull cart;
@property (nonatomic, class, readonly) id _Nonnull checkout;
@property (nonatomic, class, readonly) id _Nonnull payment;
@property (nonatomic, class, readonly) id _Nonnull search;

@end

#endif /* EventType_Ecommerce_h */
