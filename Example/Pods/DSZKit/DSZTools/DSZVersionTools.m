//
//  VersionTools.m
//  DSZ 版本升级工具类
//  这个类暂时无用
//  Created by HuHao on 15/11/5.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZVersionTools.h"
#import "DSZAlertViewTools.h"
#import "DSZTools.h"

@interface DSZVersionTools () <UIAlertViewDelegate> {
    BOOL _ifNeedUpadte;
    BOOL _BeingPressed;//判断能不能二次点击，控制点击时间差
}

@property (nonatomic, copy) NSString *downloadPath;   // 下载地址
@property (nonatomic, assign) BOOL hasAlert;

@end

@implementation DSZVersionTools
#define kUMKey @"UMKey"

+ (NSDictionary *)keys
{
    NSDictionary *dic = [DSZTools plistContentWithName:@"keys"];
    return dic;
}


+ (NSString *)getUMKey
{
    NSDictionary *keys = [self keys];
    return keys[kUMKey];
}

+ (instancetype)shareInstance {
    static DSZVersionTools *sharedInstance = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


/**
 * 此方法暂时无用
 */
+ (void)checkUpdate:(BOOL)hasAlert {
    [[DSZVersionTools shareInstance] p_checkUpdate:hasAlert];
}


- (void)p_checkUpdate:(BOOL)hasAlert {
    
//    DSZNetworkStatus *NetworkStatus = [DSZNetworkStatus sharedDSZNetworkStatus];
//    //先判断有没有网络
//    BOOL isReachableViaWWAN=[NetworkStatus isReachableViaWWAN];
//    BOOL isReachableViaWifi=[NetworkStatus isReachableViaWifi];
//    if (isReachableViaWifi==false&&isReachableViaWWAN==false) {
//        [SVProgressHUD showErrorWithStatus:@"无网络连接"];
//        return;
//    }
    
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
    
    NSString *path = self.downloadPath;
    if (path.length == 0) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:path];
    [[UIApplication sharedApplication] openURL:url];
    
}

@end
