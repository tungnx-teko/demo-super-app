//
//  UIKitInjectorControlHandler+Internal.m
//  TekoTracker
//
//  Created by Dung Nguyen on 8/10/20.
//

#import <UIKitInjectorControlHandler+Internal.h>

@implementation UIKitInjectorControlHandler {
    __weak UIKitInjector *_injector;
    UIControlEvents _controlEvent;
}

- (instancetype)initWithInjector:(UIKitInjector *)injector controlEvent:(UIControlEvents)controlEvent {
    self = [super init];
    if (self) {
        self->_injector = injector;
        self->_controlEvent = controlEvent;
    }
    return self;
}

- (void)handleControlEvent:(nonnull UIControl *)control {
    UIKitInjector *injector = self->_injector;
    if (!injector) {
        return;
    }
    [injector.delegate uiKitInjector:injector handleControl:control withControlEvent:self->_controlEvent];
}

@end
