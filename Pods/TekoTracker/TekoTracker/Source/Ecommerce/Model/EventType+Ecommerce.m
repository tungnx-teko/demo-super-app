//
//  EventType+Ecommerce.m
//  TekoTracker
//
//  Created by Dung Nguyen on 2/28/20.
//

#import "EventType+Ecommerce.h"

@implementation EventType (Ecommerce)

static id _cart;
static id _checkout;
static id _payment;
static id _search;

+ (id)cart {
    if (!_cart) {
        _cart = [[self alloc] initWithValue:@"CartEvent" schemaIdentifier:@"mobile.cartEvent"];
    }
    return _cart;
}

+ (id)checkout {
    if (!_checkout) {
        _checkout = [[self alloc] initWithValue:@"CheckoutEvent" schemaIdentifier:@"mobile.checkoutEvent"];
    }
    return _checkout;
}

+ (id)payment {
    if (!_payment) {
        _payment = [[self alloc] initWithValue:@"PaymentEvent" schemaIdentifier:@"mobile.paymentEvent"];
    }
    return _payment;
}

+ (id)search {
    if (!_search) {
        _search = [[self alloc] initWithValue:@"SiteSearchEvent" schemaIdentifier:@"mobile.siteSearchEvent"];
    }
    return _search;
}

@end
