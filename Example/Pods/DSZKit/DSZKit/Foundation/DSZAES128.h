//
//  DSZAES128.h
//  DSZ
//
//  Created by DSZ on 2017/3/31.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSZAES128 : NSObject

/**
 AES128 加密
 @param text 明文
 @param key 加密密钥
 @reture 密文
 */
+ (NSString *)AES128Encrype:(NSString *)text key:(NSString *)key;

/**
 AES128 解密
 @param encrypeText 密文
 @param key 解密密钥
 @reture 明文
 */
+ (NSString *)AES128Decrype:(NSString *)encrypeText key:(NSString *)key;

@end
