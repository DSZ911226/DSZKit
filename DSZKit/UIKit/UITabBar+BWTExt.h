//
//  UITabBar+BWTExt.h
//  BWT UITabBar类别
//
//  Created by 小广 on 15/11/28.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (BWTExt)

- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点

@end
