//
//  UITabBar+DSZExt.h
//  DSZ UITabBar类别
//
//  Created by 小广 on 15/11/28.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (DSZExt)

- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点

@end
