//
//  OKObserver.h
//  Pods
//
//  Created by Draveness on 5/18/16.
//
//

#import <Foundation/Foundation.h>
#import "EXTKeyPathCoding.h"

#define OKObserve(OBSERVEE, KEYPATH) [OKObserver observerWithObservee:OBSERVEE keypath:@keypath(OBSERVEE, KEYPATH)]

@interface OKObserver : NSObject

- (instancetype)initWithObservee:(id)observee keypath:(NSString *)keypath;

+ (OKObserver *)observerWithObservee:(id)observee keypath:(NSString *)keypath;

- (void)whenUpdated:(void(^)(id newValue))updateBlock;

- (void)update:(OKObserver *)observer;

@end
