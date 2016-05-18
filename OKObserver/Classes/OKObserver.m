//
//  OKObserver.m
//  Pods
//
//  Created by Draveness on 5/18/16.
//
//

#import "OKObserver.h"
#import "NSObject+ObservingKeypath.h"

@import ObjectiveC.runtime;
@import ObjectiveC.message;

@interface OKObserver ()

@property (nonatomic, weak) id observee;
@property (nonatomic, strong) NSString *keypath;

@property (nonatomic, copy) void(^updateBlock)(id newValue);

@end

@implementation OKObserver


static NSMutableArray *SwizzledDeallocClasses;

+ (void)load {
    SwizzledDeallocClasses = [[NSMutableArray alloc] init];
}

+ (OKObserver *)observerWithObservee:(id)observee keypath:(NSString *)keypath {
    OKObserver *observer = [[OKObserver alloc] initWithObservee:observee keypath:keypath];

    return observer;
}

- (instancetype)initWithObservee:(id)observee keypath:(NSString *)keypath {
    if (self = [super init]) {
        _observee = observee;
        _keypath = keypath;

        [_observee addObserver:self
                    forKeyPath:keypath
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
        [[_observee observingKeypath] addObject:keypath];
        [self swizzledDeallocSelectorForObject:_observee];

    }
    return self;
}

- (void)whenUpdated:(void (^)(id))updateBlock {
    _updateBlock = updateBlock;
    id newValue = [self.observee valueForKeyPath:self.keypath];
    _updateBlock(newValue);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:self.keypath]) {
        id newValue = change[NSKeyValueChangeNewKey];
        _updateBlock(newValue);
    }
}

#pragma mark - Swizzling

- (void)swizzledDeallocSelectorForObject:(id)observee {
    Class classToSwizzle = [_observee class];

    @synchronized (SwizzledDeallocClasses) {
        NSString *className = NSStringFromClass(classToSwizzle);
        if (![SwizzledDeallocClasses containsObject:className]) {
            SEL deallocSelector = sel_registerName("dealloc");

            __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;

            id newDealloc = ^(__unsafe_unretained id objSelf) {
                for (NSString *keypath in [observee observingKeypath]) {
                    [observee removeObserver:self forKeyPath:keypath];
                }
                [observee setObservingKeypath:nil];

                if (originalDealloc == NULL) {
                    struct objc_super superInfo = {
                        .receiver = objSelf,
                        .super_class = class_getSuperclass(classToSwizzle)
                    };

                    void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                    msgSend(&superInfo, deallocSelector);
                } else {
                    originalDealloc(objSelf, deallocSelector);
                }
            };

            IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);

            if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
                // The class already contains a method implementation.
                Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);

                // We need to store original implementation before setting new implementation
                // in case method is called at the time of setting.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);

                // We need to store original implementation again, in case it just changed.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
            }
            
            [SwizzledDeallocClasses addObject:className];
        }
    }
}

@end
