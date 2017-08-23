//
//  UIAlertView+BWTExt.m
//  BWT
//
//  Created by HuHao on 15/10/2.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import "UIAlertView+BWTExt.h"
#import <objc/runtime.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation UIAlertView (BWTExt)
#pragma clang diagnostic pop

- (void)setCompletionBlock:(BWTAlertViewCompletionBlock)completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (completionBlock == NULL) {
        self.delegate = nil;
    } else {
        self.delegate = self;
    }
}

- (BWTAlertViewCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, @selector(completionBlock));
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.completionBlock) {
        self.completionBlock(self, buttonIndex);
    }
}

@end
