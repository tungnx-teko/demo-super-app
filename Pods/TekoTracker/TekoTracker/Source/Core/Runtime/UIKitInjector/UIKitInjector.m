//
//  UIKitInjector.m
//  TekoTracker
//
//  Created by Dung Nguyen on 4/27/20.
//

#import "UIViewController+Tracking.h"
#import <UIKit/UIScrollView.h>
#import <UIKit/UIButton.h>
#import <UIKit/UIDatePicker.h>
#import <UIKit/UIPageControl.h>
#import <UIKit/UISegmentedControl.h>
#import <UIKit/UISlider.h>
#import <UIKit/UIStepper.h>
#import <UIKit/UISwitch.h>
#import <objc/runtime.h>
#import <UIKitInjectorControlHandler+Internal.h>

@implementation UIKitInjector {
    NSMutableDictionary *_controlEventHandlerDict;
}

@synthesize delegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        self->_controlEventHandlerDict = [[NSMutableDictionary alloc] init];
        [self inject];
    }
    return self;
}

- (void)inject {
    static dispatch_once_t UIViewControllerInjection;

    dispatch_once(&UIViewControllerInjection, ^{
        [self _inject];
    });
}

- (void)_inject {
    [self _injectViewController];
    [self _injectView];
    [self _injectScrollViewDelegates];
}

- (void)_injectViewController {
    Class viewControllerClass = [UIViewController class];
    [self swizzleViewDidLoad:viewControllerClass];
    [self swizzleViewWillAppear:viewControllerClass];
    [self swizzleViewDidAppear:viewControllerClass];
    [self swizzleViewWillDisappear:viewControllerClass];
    [self swizzleViewDidDisappear:viewControllerClass];
}

- (void)_injectView {
//    [self swizzleTouchesBegan:[UIView class]];
//    [self swizzleTouchesMoved:[UIView class]];
    [self swizzleTouchesEnded:[UIView class]];
//    [self swizzleTouchesCancelled:[UIView class]];

    [self swizzleInitWithCoder:[UIButton class] withControlEvent:UIControlEventTouchUpInside];
    [self swizzleInitWithFrame:[UIButton class] withControlEvent:UIControlEventTouchUpInside];

    [self swizzleInitWithCoder:[UIDatePicker class] withControlEvent:UIControlEventValueChanged];
    [self swizzleInitWithFrame:[UIDatePicker class] withControlEvent:UIControlEventValueChanged];

    [self swizzleInitWithCoder:[UIPageControl class] withControlEvent:UIControlEventValueChanged];
    [self swizzleInitWithFrame:[UIPageControl class] withControlEvent:UIControlEventValueChanged];

    [self swizzleInitWithCoder:[UISegmentedControl class] withControlEvent:UIControlEventValueChanged];
    [self swizzleInitWithFrame:[UISegmentedControl class] withControlEvent:UIControlEventValueChanged];

    [self swizzleInitWithCoder:[UISlider class] withControlEvent:UIControlEventValueChanged];
    [self swizzleInitWithFrame:[UISlider class] withControlEvent:UIControlEventValueChanged];

    [self swizzleInitWithCoder:[UIStepper class] withControlEvent:UIControlEventValueChanged];
    [self swizzleInitWithFrame:[UIStepper class] withControlEvent:UIControlEventValueChanged];

    [self swizzleInitWithCoder:[UISwitch class] withControlEvent:UIControlEventValueChanged];
    [self swizzleInitWithFrame:[UISwitch class] withControlEvent:UIControlEventValueChanged];
}

- (void)_injectScrollViewDelegates {
    unsigned int numOfClasses;
    Class *classes = objc_copyClassList(&numOfClasses);

    Protocol *scrollViewDelegateProtocol = @protocol(UIScrollViewDelegate);

    for (unsigned int i = 0; i < numOfClasses; i++) {
        if(class_conformsToProtocol(classes[i], scrollViewDelegateProtocol)) {
            [self swizzleScrollViewDidEndDecelerating:classes[i]];
            [self swizzleScrollViewWillEndDragging:classes[i]];
        }
    }

    free(classes);
}

#pragma mark - View Controller

- (void)swizzleViewDidLoad:(Class)class {
    SEL selector = @selector(viewDidLoad);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleViewDidLoad)(id) = ^void (id self) {

            originalIMPBlock(self, _cmd);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:didLoad:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf didLoad:self];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleViewDidLoad));
    }
}

- (void)swizzleViewWillAppear:(Class)class {
    SEL selector = @selector(viewWillAppear:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, BOOL);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleViewWillAppear)(id, BOOL) = ^void (id self, BOOL animated) {

            originalIMPBlock(self, _cmd, animated);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector: @selector(uiKitInjector:willAppear:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf willAppear:self];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleViewWillAppear));
    }
}

- (void)swizzleViewDidAppear:(Class)class {
    SEL selector = @selector(viewDidAppear:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, BOOL);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleViewDidAppear)(id, BOOL) = ^void (UIViewController *self, BOOL animated) {

            originalIMPBlock(self, _cmd, animated);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:didAppear:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf didAppear:self];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleViewDidAppear));
    }
}

- (void)swizzleViewWillDisappear:(Class)class {
    SEL selector = @selector(viewWillDisappear:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, BOOL);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleViewWillDisappear)(id, BOOL) = ^void (id self, BOOL animated) {

            originalIMPBlock(self, _cmd, animated);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:willDisappear:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf willDisappear:self];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleViewWillDisappear));
    }
}

- (void)swizzleViewDidDisappear:(Class)class {
    SEL selector = @selector(viewDidDisappear:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, BOOL);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleViewDidDisappear)(id, BOOL) = ^void (id self, BOOL animated) {

            originalIMPBlock(self, _cmd, animated);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:didDisappear:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf didDisappear:self];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleViewDidDisappear));
    }
}

#pragma mark - Touch

- (void)swizzleTouchesBegan:(Class)class {
    SEL selector = @selector(touchesBegan:withEvent:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleTouchesBegan)(id, NSSet<UITouch*> *, UIEvent *) = ^void (id self, NSSet<UITouch*> *touches, UIEvent *event) {

            [self performSelector:@selector(swizzleTouchesBegan:withEvent:) withObject:touches withObject: event];

            if (!touches || ![touches count]) {
                return;
            }

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:touchesBegan:withEvent:inView:)]) {
                NSMutableSet<UITouch *> *_touches = [[NSMutableSet alloc] init];
                for (UITouch *t in touches) {
                    if (t) {
                        [_touches addObject:t];
                    }
                }
                [weakSelf.delegate uiKitInjector:weakSelf touchesBegan:_touches withEvent:event inView:self];
            }
        };

        IMP swizzledMethod = imp_implementationWithBlock(swizzleTouchesBegan);
        class_addMethod(class, selector, swizzledMethod, method_getTypeEncoding(m));
    }
}

- (void)swizzleTouchesMoved:(Class)class {
    SEL selector = @selector(touchesMoved:withEvent:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {
        __weak UIKitInjector* weakSelf = self;

        void (^swizzleTouchesMoved)(id, NSSet<UITouch*> *, UIEvent *) = ^void (id self, NSSet<UITouch*> *touches, UIEvent *event) {

            [self performSelector:@selector(swizzleTouchesMoved:withEvent:) withObject:touches withObject: event];

            if (!touches || ![touches count]) {
                return;
            }

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:touchesMoved:withEvent:inView:)]) {
                NSMutableSet<UITouch *> *_touches = [[NSMutableSet alloc] init];
                for (UITouch *t in touches) {
                    if (t) {
                        [_touches addObject:t];
                    }
                }
                [weakSelf.delegate uiKitInjector:weakSelf touchesMoved:_touches withEvent:event inView:self];
            }
        };

        IMP swizzledMethod = imp_implementationWithBlock(swizzleTouchesMoved);
        class_addMethod(class, selector, swizzledMethod, method_getTypeEncoding(m));
    }
}

- (void)swizzleTouchesEnded:(Class)class {
    SEL selector = @selector(touchesEnded:withEvent:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleTouchesEnded)(id, NSSet<UITouch*> *, UIEvent *) = ^void (id self, NSSet<UITouch*> *touches, UIEvent *event) {

            [self performSelector:@selector(swizzleTouchesEnded:withEvent:) withObject:touches withObject: event];

            if (!touches || ![touches count]) {
                return;
            }

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:touchesEnded:withEvent:inView:)]) {
                NSMutableSet<UITouch *> *_touches = [[NSMutableSet alloc] init];
                for (UITouch *t in touches) {
                    if (t) {
                        [_touches addObject:t];
                    }
                }
                [weakSelf.delegate uiKitInjector:weakSelf touchesEnded:_touches withEvent:event inView:self];
            }
        };

        IMP swizzledMethod = imp_implementationWithBlock(swizzleTouchesEnded);
        class_addMethod(class, selector, swizzledMethod, method_getTypeEncoding(m));
    }
}

- (void)swizzleTouchesCancelled:(Class)class {
    SEL selector = @selector(touchesCancelled:withEvent:);
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        __weak UIKitInjector* weakSelf = self;

        void (^swizzleTouchesCancelled)(id, NSSet<UITouch*> *, UIEvent *) = ^void (id self, NSSet<UITouch*> *touches, UIEvent *event) {

            [self performSelector:@selector(swizzleTouchesCancelled:withEvent:) withObject:touches withObject: event];

            if (!touches || ![touches count]) {
                return;
            }

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:touchesCancelled:withEvent:inView:)]) {
                NSMutableSet<UITouch *> *_touches = [[NSMutableSet alloc] init];
                for (UITouch *t in touches) {
                    if (t) {
                        [_touches addObject:t];
                    }
                }
                [weakSelf.delegate uiKitInjector:weakSelf touchesCancelled:_touches withEvent:event inView:self];
            }
        };

        IMP swizzledMethod = imp_implementationWithBlock(swizzleTouchesCancelled);
        class_addMethod(class, selector, swizzledMethod, method_getTypeEncoding(m));
    }
}

#pragma mark - UIControl

- (void)swizzleInitWithCoder:(Class)class withControlEvent: (UIControlEvents)controlEvent {
    SEL selector = @selector(initWithCoder:);
    Method m = class_getInstanceMethod(class, selector);

    __weak UIKitInjector* weakSelf = self;

    if (m && [class instancesRespondToSelector:selector]) {
        typedef id (*OriginalIMPBlockType)(id self, SEL _cmd, NSCoder *);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        id (^swizzleInitWithCoder)(id, NSCoder *) = ^id (id self, NSCoder *coder) {
            id instance = originalIMPBlock(self, _cmd, coder);
            UIKitInjector *strongSelf = weakSelf;
            if (!strongSelf) {
                return instance;
            }
            NSString *key = [NSString stringWithFormat:@"event_%lu", (unsigned long)controlEvent];
            UIKitInjectorControlHandler *handler = [strongSelf->_controlEventHandlerDict valueForKey:key];
            if (!handler) {
                handler = [[UIKitInjectorControlHandler alloc] initWithInjector:strongSelf controlEvent:controlEvent];
                [strongSelf->_controlEventHandlerDict setValue:handler forKey:key];
            }
            [instance addTarget:handler action:@selector(handleControlEvent:) forControlEvents:controlEvent];
            return instance;
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleInitWithCoder));
    }
}

- (void)swizzleInitWithFrame:(Class)class withControlEvent: (UIControlEvents)controlEvent {
    SEL selector = @selector(initWithFrame:);
    Method m = class_getInstanceMethod(class, selector);

    __weak UIKitInjector* weakSelf = self;

    if (m && [class instancesRespondToSelector:selector]) {
        typedef id (*OriginalIMPBlockType)(id self, SEL _cmd, CGRect);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        id (^swizzleInitWithFrame)(id, CGRect) = ^id (id self, CGRect frame) {
            id instance = originalIMPBlock(self, _cmd, frame);
            UIKitInjector *strongSelf = weakSelf;
            if (!strongSelf) {
                return instance;
            }
            NSString *key = [NSString stringWithFormat:@"event_%lu", (unsigned long)controlEvent];
            UIKitInjectorControlHandler *handler = [strongSelf->_controlEventHandlerDict valueForKey:key];
            if (!handler) {
                handler = [[UIKitInjectorControlHandler alloc] initWithInjector:strongSelf controlEvent:controlEvent];
                [strongSelf->_controlEventHandlerDict setValue:handler forKey:key];
            }

            [instance addTarget:handler action:@selector(handleControlEvent:) forControlEvents:controlEvent];
            return instance;
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleInitWithFrame));
    }
}

#pragma mark - ScrollViewDelegate

- (void)swizzleScrollViewDidEndDecelerating:(Class)class {
    SEL selector = @selector(scrollViewDidEndDecelerating:);
    Method m = class_getInstanceMethod(class, selector);

    __weak UIKitInjector* weakSelf = self;

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, UIScrollView *);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        void (^swizzleDidEndDecelerating)(id, UIScrollView *) = ^void (id self, UIScrollView *scrollView) {

            originalIMPBlock(self, _cmd, scrollView);

            if (self && weakSelf && weakSelf.delegate && scrollView && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:didEndDecelerating:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf didEndDecelerating:scrollView];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleDidEndDecelerating));
    } else {
        void (^swizzleDidEndDecelerating)(id, UIScrollView *) = ^void (id self, UIScrollView *scrollView) {
            if (self && weakSelf && weakSelf.delegate && scrollView && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:didEndDecelerating:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf didEndDecelerating:scrollView];
            }
        };

        IMP swizzledMethod = imp_implementationWithBlock(swizzleDidEndDecelerating);
        class_addMethod(class, selector, swizzledMethod, "v@:@");
    }
}

- (void)swizzleScrollViewWillEndDragging:(Class)class {
    SEL selector = @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:);
    Method m = class_getInstanceMethod(class, selector);

    __weak UIKitInjector* weakSelf = self;

    if (m && [class instancesRespondToSelector:selector]) {
        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, UIScrollView *, CGPoint, CGPoint *);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        void (^swizzleScrollViewWillEndDragging)(id, UIScrollView *, CGPoint, CGPoint *) = ^void (id self, UIScrollView *scrollView, CGPoint velocity, CGPoint *targetContentOffset) {

            originalIMPBlock(self, _cmd, scrollView, velocity, targetContentOffset);

            if (self && weakSelf && weakSelf.delegate && scrollView && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:willEndDragging:withVelocity:targetContentOffset:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf willEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzleScrollViewWillEndDragging));
    } else {
        void (^swizzleScrollViewWillEndDragging)(id, UIScrollView *, CGPoint velocity, CGPoint *targetContentOffset) = ^void (id self, UIScrollView *scrollView, CGPoint velocity, CGPoint *targetContentOffset) {
            if (self && weakSelf && weakSelf.delegate && scrollView && [weakSelf.delegate respondsToSelector:@selector(uiKitInjector:willEndDragging:withVelocity:targetContentOffset:)]) {
                [weakSelf.delegate uiKitInjector:weakSelf willEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
            }
        };

        IMP swizzledMethod = imp_implementationWithBlock(swizzleScrollViewWillEndDragging);
        class_addMethod(class, selector, swizzledMethod, [[NSString stringWithFormat:@"v@:@:%s:N^%s", @encode(CGPoint), @encode(CGPoint)] UTF8String]);
    }
}

@end
