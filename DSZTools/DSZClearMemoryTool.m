//
//  DSZClearMemoryTool.m
//  DSZ  清除缓存的工具类
//
//  Created by 小广 on 15/10/19.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZClearMemoryTool.h"


@implementation DSZClearMemoryTool

+ (DSZClearMemoryTool *)shareInstance {
    
    static DSZClearMemoryTool *tool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[DSZClearMemoryTool alloc] init];
    });
    return tool;
}

// 读取大小M
- (CGFloat)checkTmpSize {
    
    NSString  *diskCachePath = [[SDImageCache sharedImageCache] valueForKey:@"diskCachePath"];
    CGFloat totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:diskCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
        totalSize += length / 1024.0 / 1024.0;
    }
    // DSZLog(@"tmp size is %.2f",totalSize);
    return totalSize;
}

- (NSString *)memorySize {
    CGFloat tmpSize = [self checkTmpSize];
    NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"%.2fM",tmpSize] : [NSString stringWithFormat:@"%.2fK",tmpSize * 1024];
    return clearCacheName;
}

- (void)clearMemory:(SDWebImageNoParamsBlock)block {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:block];
}

@end
