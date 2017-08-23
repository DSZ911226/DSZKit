//
//  UIViewController+BWTExt.m
//  BWTSH
//
//  Created by HuHao on 1/11/16.
//  Copyright © 2016 BWT. All rights reserved.
//

#import "UIViewController+BWTExt.h"
#import "NSObject+BWTExt.h"

@implementation UIViewController (BWTExt)

static UIViewController *lastVC = nil;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(_viewWillAppear:) tarSel:@selector(viewWillAppear:)];
    });
    
}

- (void)_viewWillAppear:(BOOL)animated {

    if ([self checkIsSystemController]) {
        return;
    }

    lastVC = self;
    [self _viewWillAppear:animated];
}


- (BOOL)checkIsSystemController {

    NSString *className = [self className];
    NSString *regex = @"^UI.*?Controller$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:className];
    if (isValid) {
        return YES;
    }

    if ([self isMemberOfClass:[UIAlertController class]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    
    if([self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        return YES;
    }

    if([self isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingController")]) {
        return YES;
    }

    if ([self isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")]) {
        return YES;
    }

    return NO;
}



+ (UIViewController *)lastViewController {
    return lastVC;
}

@end
