//
//  LoaderEcommerce+Internal.m
//  TekoTracker
//
//  Created by Dung Nguyen on 2/26/20.
//

#import "TrackerController+Internal.h"
#import "Util+Internal.h"
#import "Loader+Internal.h"

@implementation Loader (Ecommerce)

+ (void)load {
    static dispatch_once_t onceToken;
    Class swizzledClass = [[TrackerController self] class];
    dispatch_once(&onceToken, ^{
        swizzling(swizzledClass,
                  @selector(createScreenViewDataFromViewController:lastScreenViewName:navigationStart:loadEventEnd:),
                  @selector(ecommerce_createScreenViewDataFromViewController:lastScreenViewName:navigationStart:loadEventEnd:));
    });
}

@end
