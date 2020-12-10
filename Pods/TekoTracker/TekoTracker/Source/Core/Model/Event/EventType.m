//
//  EventType.m
//  TekoTracker
//
//  Created by Dung Nguyen on 2/28/20.
//

#import <Foundation/Foundation.h>
#import <EventType.h>
#import <objc/runtime.h>

@implementation EventType {
    NSString *_value;
    NSString *_schemaIdentifier;
}

static id _alert;
static id _custom;
static id _errorET;
static id _interaction;
static id _performanceTiming;
static id _screenView;
static id _timing;
static id _visibleContent;

- (instancetype)initWithValue:(NSString *)value schemaIdentifier:(NSString *)schemaIdentifier {
    self = [super init];
    if (self) {
        _value = value;
        _schemaIdentifier = schemaIdentifier;
    }
    return self;
}

- (NSString *)value {
    return _value;
}

- (NSString *)schemaIdentifier {
    return _schemaIdentifier;
}

+ (id)alert {
    if (!_alert) {
        _alert = [[self alloc] initWithValue:@"AlertEvent" schemaIdentifier:@"mobile.alertEvent"];
    }
    return _alert;
}

+ (id)custom {
    if (!_custom) {
        _custom = [[self alloc] initWithValue:@"CustomEvent" schemaIdentifier:@"mobile.customEvent"];
    }
    return _custom;
}

+ (id)error {
    if (!_errorET) {
        _errorET = [[self alloc] initWithValue:@"ErrorEvent" schemaIdentifier:@"mobile.errorEvent"];
    }
    return _errorET;
}

+ (id)interaction {
    if (!_interaction) {
        _interaction = [[self alloc] initWithValue:@"ContentEvent" schemaIdentifier:@"mobile.interactionContentEvent"];
    }
    return _interaction;
}

+ (id)performanceTiming {
    if (!_performanceTiming) {
        _performanceTiming = [[self alloc] initWithValue:@"PerformanceTimingEvent" schemaIdentifier:@"mobile.performanceTimingEvent"];
    }
    return _performanceTiming;
}

+ (id)screenView {
    if (!_screenView) {
        _screenView = [[self alloc] initWithValue:@"ScreenView" schemaIdentifier:@"mobile.screenView"];
    }
    return _screenView;
}

+ (id)timing {
    if (!_timing) {
        _timing = [[self alloc] initWithValue:@"TimingEvent" schemaIdentifier:@"mobile.timingEvent"];
    }
    return _timing;
}

+ (id)visibleContent {
    if (!_visibleContent) {
        _visibleContent = [[self alloc] initWithValue:@"ContentEvent" schemaIdentifier:@"mobile.visibleContentEvent"];
    }
    return _visibleContent;
}

@end
