//
//  UIAlertView+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
typedef void (^DSZAlertViewCompletionBlock)(UIAlertView *alertView, NSInteger buttonIndex);
#pragma clang diagnostic pop

@interface UIAlertView (DSZExt) <UIAlertViewDelegate>

- (void)setCompletionBlock:(DSZAlertViewCompletionBlock)completionBlock;
- (DSZAlertViewCompletionBlock)completionBlock;

@end
