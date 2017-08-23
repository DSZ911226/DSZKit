//
//  UIAlertView+DSZExt.m
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "UIAlertView+DSZExt.h"
#import <objc/runtime.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation UIAlertView (DSZExt)
#pragma clang diagnostic pop

- (void)setCompletionBlock:(DSZAlertViewCompletionBlock)completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (completionBlock == NULL) {
        self.delegate = nil;
    } else {
        self.delegate = self;
    }
}

- (DSZAlertViewCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, @selector(completionBlock));
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.completionBlock) {
        self.completionBlock(self, buttonIndex);
    }
}

@end
