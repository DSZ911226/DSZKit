//
//  DSZClearMemoryTool.h
//  DSZ  清除缓存的工具类
//
//  Created by 小广 on 15/10/19.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDImageCache.h"

@interface DSZClearMemoryTool : NSObject

+ (DSZClearMemoryTool *)shareInstance;
- (CGFloat)checkTmpSize;///< 读取缓存大小
- (NSString *)memorySize;///< 读取缓存大小(string)
- (void)clearMemory:(SDWebImageNoParamsBlock)block;///< 清除缓存

@end
