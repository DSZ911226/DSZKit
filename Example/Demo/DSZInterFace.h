//
//  DSZInterFace.h
//  Demo
//
//  Created by zhilvmac on 2017/9/19.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <ReactiveObjC.h>
#import<DSZKitMacro.h>
typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^FailureBlock)(id error);

typedef enum : NSUInteger {
    POST,
    GET,
} REQUEST_TYPE;

@interface DSZInterFace : NSObject



 
/**
 网络请求
 
 @param requestType 请求类型
 @param responseClass 解析后需要转化成的model类
 @param urlStr 请求网址
 @param parameters 请求参数
 @param success 成功返回
 @param failure 失败返回
 @return 信号
 */
+ (RACSignal *)RequestWithType:(REQUEST_TYPE)requestType
                 responseClass:(Class)responseClass
                        urlStr:(NSString *)urlStr
                    parameters:(NSString *)parameters
                       success:(HttpSuccessBlock)success
                       failure:(FailureBlock)failure;






@end
