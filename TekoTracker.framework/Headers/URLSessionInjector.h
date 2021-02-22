//
//  URLSessionInjector.h
//  TekoTracker
//
//  Created by Dung Nguyen on 4/27/20.
//

#ifndef URLSessionInjector_h
#define URLSessionInjector_h

#import <Foundation/NSURLSession.h>

@class URLSessionInjector;

@protocol URLSessionInjectorDelegate <NSObject>

@optional
- (void)urlSessionInjector:(nonnull URLSessionInjector*)injector didStart:(nonnull NSURLSessionDataTask*)dataTask;

- (void)urlSessionInjector:(nonnull URLSessionInjector*)injector didReceiveResponse:(nonnull NSURLSessionDataTask*)dataTask response:(nonnull NSURLResponse*)response;

- (void)urlSessionInjector:(nonnull URLSessionInjector*)injector didReceiveData:(nonnull NSURLSessionDataTask*)dataTask data:(nonnull NSData*)data;

- (void)urlSessionInjector:(nonnull URLSessionInjector*)injector didFinishWithError:(nonnull NSURLSessionDataTask*)dataTask error:(nullable NSError*)error;

@end

@interface URLSessionInjector : NSObject

@property (nonatomic, weak, nullable) id<URLSessionInjectorDelegate> delegate;
@property (nonatomic, class, nonnull, readonly) URLSessionInjector *shared;

- (instancetype _Nonnull) init NS_UNAVAILABLE;

@end

#endif /* URLSessionInjector_h */
