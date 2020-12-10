//
//  UIKitInjectorControlHandler+Internal.h
//  TekoTracker
//
//  Created by Dung Nguyen on 8/10/20.
//

#ifndef UIKitInjectorControlHandler_Internal_h
#define UIKitInjectorControlHandler_Internal_h

#import <UIKit/UIKit.h>
#import <UIKitInjector.h>

@interface UIKitInjectorControlHandler : NSObject

- (nonnull instancetype)initWithInjector:(nonnull UIKitInjector *)injector controlEvent:(UIControlEvents)controlEvent;

@end

#endif /* UIKitInjectorControlHandler_Internal_h */
