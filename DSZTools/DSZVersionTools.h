//
//  DSZVersionTools.h
//  DSZ 版本升级工具类
//
//  Created by HuHao on 15/11/5.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DSZVersionToolsBlock)();

@interface DSZVersionTools : NSObject

/**
 *  检查版本更新
 *
 *  @param hasAlert YES-正在加载中提示，最新更新是否提醒  NO-无任何提醒，只有升级才弹出升级提醒
 */
+ (void)checkUpdate:(BOOL)hasAlert;

@end
