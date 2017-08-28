//
//  DSZErrorTools.h
//  MSX NSError处理类
//
//  Created by 胡浩 on 2017/6/16.
//  Copyright © 2017年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

//typedef NS_ENUM(NSInteger, DSZErrorCode) {
//    DSZFieldCheck = 80001,              // 表单字段检测异常
//    DSZTokenInvalid = 80002,            // token失效
//    DSZVerifySignatureError = 80003,    // 验签失败
//    DSZAppUpdatePrompt = 80004,         // App升级提醒
//    DSZUserInvalidError = 80005,        // 用户失效(用户加入黑名单、销户)
//    DSZResponseDataError = 80006,       // 服务端返回数据异常(比如数据为空, 数据格式不对)
//    DSZLocalNotNetwork = 80007,         // 当前设备无网络
//};


typedef NS_ENUM(NSInteger, DSZErrorType) {
    DSZNormalError = 80001,             // 普通提醒，显示错误之后自动隐藏
    DSZAlertAndLoginError = 80002,      // 弹窗提醒, 点击确定之后需要跳转登录, 不可取消
    DSZAppUpdatePrompt = 80003,         // 弹窗提醒, 点击确定之后需要跳转到升级页面, 可取消
    DSZAlertError = 80004,              // 弹窗提醒, 点击确定无操作
    DSZNeedLogin = 80005,               // 不给提示, 直接跳转到登录页面
    DSZNotNetwork = 80006,              // 无网络, 需要弹出提示, 用户需要点击重试
};




#define kDSZErrorDomain @"com.DSZon.app"

// 创建NSError实体类
#define DSZError(errorCode, message) [NSError errorWithDomain:kDSZErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey: message}]
#define DSZErrorCode(x) [DSZErrorTools errorCodeWithTuple:x];
#define DSZErrorMessage(x) [DSZErrorTools errorMessageWithTuple:x];

@interface DSZErrorTools : NSObject


/**
 创建NSError

 @param errorCode 错误编码
 @param message 错误信息
 @return NSError实体类
 */
+ ( NSError *_Nonnull)errorWithCode:(DSZErrorType)errorCode
                            message:(NSString *_Nullable)message;

/**
 获取错误code
 
 @param tupleObj 元组
 @return 错误Code
 */
+ (NSString *_Nullable)errorCodeWithTuple:(RACTuple *_Nullable)tupleObj;


/**
 获取错误消息
 
 @param tupleObj 元组
 @return 错误消息
 */
+ (NSString *_Nullable)errorMessageWithTuple:(RACTuple *_Nullable)tupleObj;


@end
