//
//  Firstmodel.h
//  Demo
//
//  Created by zhilvmac on 2017/8/28.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import <DSZKit/DSZKit.h>
#import "DSZKitMacro.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface Firstmodel : DSZBaseViewModel
@property(nonatomic,copy)NSString *name;

+ (RACSignal *)buzhidao;
@end
