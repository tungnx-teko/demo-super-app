//
//  Util+Internal.h
//  TekoTracker
//
//  Created by Dung Nguyen on 1/20/20.
//

#ifndef Util_Internal_h
#define Util_Internal_h

#import <objc/objc.h>

void swizzling(Class swizzedClass, SEL originalSelector, SEL swizzledSelector);

#endif /* Util_Internal_h */
