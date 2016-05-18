//
//  OKViewController.m
//  OKObserver
//
//  Created by Draveness on 05/18/2016.
//  Copyright (c) 2016 Draveness. All rights reserved.
//

#import "OKViewController.h"
#import "OKObserver.h"
#import "XXObject.h"

@interface OKViewController ()

@end

@implementation OKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XXObject *object = [XXObject new];
    object.color = [UIColor redColor];
    [OKObserve(object, color) update:OKObserve(self, view.backgroundColor)];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        object.color = [UIColor yellowColor];
    });
}

@end
