//
//  UIAlertView+BWTExt.h
//  BWT
//
//  Created by HuHao on 15/10/2.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
typedef void (^BWTAlertViewCompletionBlock)(UIAlertView *alertView, NSInteger buttonIndex);
#pragma clang diagnostic pop

@interface UIAlertView (BWTExt) <UIAlertViewDelegate>

- (void)setCompletionBlock:(BWTAlertViewCompletionBlock)completionBlock;
- (BWTAlertViewCompletionBlock)completionBlock;

@end
