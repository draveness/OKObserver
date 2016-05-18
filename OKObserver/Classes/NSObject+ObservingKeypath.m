//
//  NSObject+ObservingKeypath.m
//  Pods
//
//  Created by Draveness on 5/18/16.
//
//

#import "NSObject+ObservingKeypath.h"

@import ObjectiveC.runtime;
@import ObjectiveC.message;


@implementation NSObject (ObservingKeypath)

- (NSMutableArray *)observingKeypath {
    NSMutableArray *result = objc_getAssociatedObject(self, @selector(observingKeypath));
    if (!result) {
        result = [[NSMutableArray alloc] init];
        [self setObservingKeypath:result];
    }
    return result;
}

- (void)setObservingKeypath:(NSMutableArray *)observingKeypath {
    objc_setAssociatedObject(self, @selector(observingKeypath), observingKeypath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

