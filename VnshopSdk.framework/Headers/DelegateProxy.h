//
//  DelegateProxy.h
//  VNShop
//
//  Created by tuananh on 10/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface STDelegateProxy : NSObject
- (nonnull instancetype)initWithDelegates:(NSArray<id> * __nonnull)delegates NS_REFINED_FOR_SWIFT;
@end
