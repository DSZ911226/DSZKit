//
//  DSZBaseViewModel.m
//  MSX
//
//  Created by 胡浩 on 2017/6/15.
//  Copyright © 2017年 DSZ. All rights reserved.
//

#import "DSZBaseViewModel.h"
#import "DSZKitMacro.h"

@implementation DSZBaseViewModel

- (void)dealloc
{
    DSZLog(@"DSZBaseViewModel")
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self DSZ_init];
    }
    return self;
}

- (void)DSZ_init {
    DAssert(0)
    DSZLog(@"必须重写父类方法");
}

@end
