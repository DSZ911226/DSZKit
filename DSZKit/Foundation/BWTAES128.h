//
//  BWTAES128.h
//  BWT
//
//  Created by Huhao on 2017/3/31.
//  Copyright © 2017年 八维通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWTAES128 : NSObject

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
