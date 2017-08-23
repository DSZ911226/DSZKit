//
//  UINavigationController+DSZExt.m
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "UINavigationController+DSZExt.h"
#import <objc/runtime.h>
#import "UIImage+DSZExt.h"
#import "DSZKitMacro.h"


@interface UINavigationController ()

@end

@implementation UINavigationController (DSZExt)

@dynamic screenEdgePanGestureRecognizer;

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }

    return screenEdgePanGestureRecognizer;
}




@end
