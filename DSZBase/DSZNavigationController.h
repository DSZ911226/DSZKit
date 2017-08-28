//
//  KLNavigationController.h
//  DSZ
//  Created by HuHao on 15/4/9.
//  Copyright (c) 2015年 DSZon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSZNavigationController : UINavigationController

/**
 *  替换最后一个ViewController
 *
 *  @param vc 新的VC
 */
- (void)replaceLastViewController:(UIViewController *)vc;

/**
 *  在最后一个ViewController上在增加一个
 *
 *  @param vc 新的VC
 */
- (void)addViewController:(UIViewController *)vc;

@end
