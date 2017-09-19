//
//  DSZInterFace.m
//  Demo
//
//  Created by zhilvmac on 2017/9/19.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import "DSZInterFace.h"

@interface DSZInterFace()

@end

@implementation DSZInterFace
static AFHTTPSessionManager *manager = nil;
NSURLSessionTask *currentTask = nil;//当前的任务
+(AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/plain", @"text/html",@"application/octet-stream", nil];
        manager.requestSerializer.timeoutInterval = 10;
        
        
    });
    return manager;
}


+(RACSignal *)RequestWithType:(REQUEST_TYPE)requestType responseClass:(Class)responseClass urlStr:(NSString *)urlStr parameters:(NSString *)parameters success:(HttpSuccessBlock)success failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [DSZInterFace sharedHTTPSession];
    
    if (requestType == POST) {
        currentTask = [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }else{
        
    }
    
    
    
    
}





@end
