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


+(RACSignal *)RequestWithType:(REQUEST_TYPE)requestType urlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(HttpSuccessBlock)success failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [DSZInterFace sharedHTTPSession];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        if (requestType == POST) {
            currentTask = [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendNext:error];
                [subscriber sendCompleted];
            }];
            
        }else{
            currentTask = [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendNext:error];
                [subscriber sendCompleted];
            }];
        }

        
        return [RACDisposable disposableWithBlock:^{
            
        }];
        
    }];
    
    
    return signal;
    
}





@end
