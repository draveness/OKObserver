//
//  NSObject+ObservingKeypath.h
//  Pods
//
//  Created by Draveness on 5/18/16.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (ObservingKeypath)

@property (nonatomic, strong) NSMutableArray<NSString *> *observingKeypath;

@end
