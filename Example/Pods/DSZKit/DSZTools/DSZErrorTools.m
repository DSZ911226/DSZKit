//
//  DSZErrorTools.m
//  MSX NSError处理类
//
//  Created by 胡浩 on 2017/6/16.
//  Copyright © 2017年 DSZ. All rights reserved.
//

#import "DSZErrorTools.h"
#import "DSZKit.h"

@interface DSZErrorTools ()

@end

@implementation DSZErrorTools

+ (NSError *)errorWithCode:(DSZErrorType)errorCode
                   message:(NSString *)message {
    NSError *error = DSZError(errorCode, message);
    return error;
}

+ (NSString *)errorCodeWithTuple:(RACTuple *)tupleObj {
    NSString *errorCode = nil;
    
    // FIXME 这里用kindOfClass 会匹配不上，目前还未找到原因，所以用字符串来匹配(这里会有问题，在AppDelegate中又正常)
    if([tupleObj.className rangeOfString:@"Tuple"].location != NSNotFound) {
        RACTupleUnpack(NSString *message, NSString *code) = tupleObj;
        DSZLog(@"message ==== %@, code ===== %@", message, code);
        errorCode = code;
    }
    
    return errorCode;
}

+ (NSString *)errorMessageWithTuple:(RACTuple *)tupleObj {
    NSString *errorMessage = nil;
    
    if([tupleObj.className rangeOfString:@"Tuple"].location != NSNotFound) {
        RACTupleUnpack(NSString *message) = tupleObj;
        DSZLog(@"message ==== %@", message);
        errorMessage = message;
    }
    
    return errorMessage;
}

@end
