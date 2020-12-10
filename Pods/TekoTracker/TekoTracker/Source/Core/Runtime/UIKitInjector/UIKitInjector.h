//
//  UIKitInjector.h
//  TekoTracker
//
//  Created by Dung Nguyen on 4/27/20.
//

#ifndef UIKitInjector_h
#define UIKitInjector_h

#import <UIKit/UIViewController.h>
#import <UIKit/UIView.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIEvent.h>

@class UIKitInjector;

@protocol UIKitInjectorDelegate <NSObject>

@optional
- (void)uiKitInjector:(nonnull UIKitInjector*)injector didLoad:(nonnull UIViewController *)viewController;
- (void)uiKitInjector:(nonnull UIKitInjector*)injector willAppear:(nonnull UIViewController *)viewController;
- (void)uiKitInjector:(nonnull UIKitInjector*)injector didAppear:(nonnull UIViewController *)viewController;
- (void)uiKitInjector:(nonnull UIKitInjector*)injector willDisappear:(nonnull UIViewController *)viewController;
- (void)uiKitInjector:(nonnull UIKitInjector*)injector didDisappear:(nonnull UIViewController *)viewController;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector touchesBegan:(nonnull NSSet<UITouch*> *)touches withEvent:(nullable UIEvent *)event inView:(nonnull UIView*)view;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector touchesMoved:(nonnull NSSet<UITouch*> *)touches withEvent:(nullable UIEvent *)event inView:(nonnull UIView*)view;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector touchesEnded:(nonnull NSSet<UITouch*> *)touches withEvent:(nullable UIEvent *)event inView:(nonnull UIView*)view;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector touchesCancelled:(nonnull NSSet<UITouch*> *)touches withEvent:(nullable UIEvent *)event inView:(nonnull UIView*)view;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector didEndDecelerating:(nonnull UIScrollView *)scrollView;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector willEndDragging:(nonnull UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(nonnull CGPoint *)targetContentOffset;
- (void)uiKitInjector:(nonnull UIKitInjector *)injector handleControl:(nonnull UIControl *)control withControlEvent:(UIControlEvents) controlEvent;

@end

@interface UIKitInjector : NSObject

@property (nonatomic, weak, nullable) id<UIKitInjectorDelegate> delegate;

@end

#endif /* UIKitInjector_h */
