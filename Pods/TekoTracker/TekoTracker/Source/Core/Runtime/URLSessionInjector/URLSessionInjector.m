//
//  URLSessionInjector.m
//  TekoTracker
//
//  Created by Dung Nguyen on 4/27/20.
//

#import <Foundation/Foundation.h>
#import "URLSessionInjector.h"
#include <objc/runtime.h>

@implementation URLSessionInjector

- (instancetype)init {
    self = [super init];

    if (self) {
        [self inject];
    }

    return self;
}

/*
 dump:
 - (void)_didFinishWithError:(id)arg1;
 - (void)_didReceiveData:(id)arg1;
 - (void)_didReceiveResponse:(id)arg1 sniff:(bool)arg2; // ~> iOS 12
 - (void)_didReceiveResponse:(id)arg1 sniff:(bool)arg2 rewrite:(bool)arg3; // iOS 13
 
 https://github.com/JackRostron/iOS8-Runtime-Headers
 https://github.com/ksenks/iOS9-Runtime-Headers
 https://github.com/JaviSoto/iOS10-Runtime-Headers
 https://github.com/LeoNatan/Apple-Runtime-Headers
 */

#pragma mark NSURLSession Injection

- (void)inject {
    static dispatch_once_t NSURLSessionInjectionOnce;

    dispatch_once(&NSURLSessionInjectionOnce, ^{
        [self _inject];
    });
}

- (void)_inject {
    //iOS8          : __NSCFURLSessionConnection
    //iOS9,10,11    : __NSCFURLLocalSessionConnection

    Class sessionClass = NSClassFromString(@"__NSCFURLLocalSessionConnection");
    Class taskClass = NSClassFromString(@"__NSCFURLSessionTask");

    if (sessionClass == nil) {
        sessionClass = NSClassFromString(@"__NSCFURLSessionConnection");
    }

    if (sessionClass) {
        [self swizzleSessionDidReceiveData:sessionClass];
        [self swizzleSessionDidReceiveResponse:sessionClass];
        [self swizzleSessiondDidFinishWithError:sessionClass];
    }

    if (taskClass) {
        [self swizzleSessionTaskResume:taskClass];
    }
}

- (void)swizzleSessionTaskResume:(Class) class {
    SEL selector = NSSelectorFromString(@"resume");
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak URLSessionInjector* weakSelf = self;

        void (^swizzledSessionTaskResume)(id) = ^void(id self) {

            originalIMPBlock(self, _cmd);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(urlSessionInjector:didStart:)]) {
                [weakSelf.delegate urlSessionInjector:weakSelf didStart:self];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzledSessionTaskResume));
    }
}

- (void)swizzleSessionDidReceiveResponse : (Class) class {
    if (@available(iOS 13.0, *)) {
        SEL selector = NSSelectorFromString(@"_didReceiveResponse:sniff:rewrite:");
        Method m = class_getInstanceMethod(class, selector);

        if (m && [class instancesRespondToSelector:selector]) {

            typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, id arg1, BOOL sniff, BOOL rewrite);
            OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

            __weak URLSessionInjector* weakSelf = self;

            void (^swizzledSessionDidReceiveResponse)(id, id, BOOL, BOOL) = ^void(id self, id arg1, BOOL sniff, BOOL rewrite) {

                originalIMPBlock(self, _cmd, arg1, sniff, rewrite);

                if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(urlSessionInjector:didReceiveResponse:response:)]) {
                    [weakSelf.delegate urlSessionInjector:weakSelf didReceiveResponse:[self valueForKey:@"task"] response:arg1];
                }
            };

            method_setImplementation(m, imp_implementationWithBlock(swizzledSessionDidReceiveResponse));
        }
        return;
    }

    SEL selector = NSSelectorFromString(@"_didReceiveResponse:sniff:");
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, id arg1, BOOL sniff);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak URLSessionInjector* weakSelf = self;

        void (^swizzledSessionDidReceiveResponse)(id, id, BOOL) = ^void(id self, id arg1, BOOL sniff) {

            originalIMPBlock(self, _cmd, arg1, sniff);

            if (self && weakSelf && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(urlSessionInjector:didReceiveResponse:response:)]) {
                [weakSelf.delegate urlSessionInjector:weakSelf didReceiveResponse:[self valueForKey:@"task"] response:arg1];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzledSessionDidReceiveResponse));
    }
}

- (void)swizzleSessionDidReceiveData : (Class) class {
    SEL selector = NSSelectorFromString(@"_didReceiveData:");
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, id arg1);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak URLSessionInjector* weakSelf = self;

        void (^swizzledSessionDidReceiveData)(id, id) = ^void(id self, id arg1) {

            originalIMPBlock(self, _cmd, arg1);

            NSURLSessionDataTask *task = [self valueForKey:@"task"];
            if (self && weakSelf && arg1 && task && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(urlSessionInjector:didReceiveData:data:)]) {
                [weakSelf.delegate urlSessionInjector:weakSelf didReceiveData:task data:[arg1 copy]];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzledSessionDidReceiveData));
    }
}

- (void)swizzleSessiondDidFinishWithError : (Class) class {
    SEL selector = NSSelectorFromString(@"_didFinishWithError:");
    Method m = class_getInstanceMethod(class, selector);

    if (m && [class instancesRespondToSelector:selector]) {

        typedef void (*OriginalIMPBlockType)(id self, SEL _cmd, id arg1);
        OriginalIMPBlockType originalIMPBlock = (OriginalIMPBlockType)method_getImplementation(m);

        __weak URLSessionInjector* weakSelf = self;

        void (^swizzledSessiondDidFinishWithError)(id, id) = ^void(id self, id arg1) {

            originalIMPBlock(self, _cmd, arg1);

            NSURLSessionDataTask *task = [self valueForKey:@"task"];
            if (self && weakSelf && task && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(urlSessionInjector:didFinishWithError:error:)]) {
                [weakSelf.delegate urlSessionInjector:weakSelf didFinishWithError:task error:arg1];
            }
        };

        method_setImplementation(m, imp_implementationWithBlock(swizzledSessiondDidFinishWithError));
    }
}

@end
