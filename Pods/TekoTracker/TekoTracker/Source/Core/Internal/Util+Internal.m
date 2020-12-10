//
//  Util+Internal.m
//  TekoTracker
//
//  Created by Dung Nguyen on 1/15/20.
//

#import <objc/runtime.h>
#import "Util+Internal.h"

void swizzling(Class swizzedClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(swizzedClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzedClass, swizzledSelector);

    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    // Method originalMethod = class_getClassMethod(class, originalSelector);
    // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

    BOOL didAddMethod =
    class_addMethod(swizzedClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(swizzedClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
