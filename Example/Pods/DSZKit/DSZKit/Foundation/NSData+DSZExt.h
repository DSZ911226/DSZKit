//
//  NSData+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/1.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DSZExt)

/**
 *  将NSData对象转换为md5的字符串
 *
 *  @return md5字符串
 */
- (NSString *)md5String;


/**
 *  将NSData对象转换为十六进制的字符串
 *
 *  @return 十六进制的字符串
 */
- (NSString *)hexString;

/**
 *  将NSData对象换成md5的NSData
 *
 *  @return md5 NSData
 */
- (NSData *)md5Data;


/**
 *  AES256加密
 *
 *  @param key 键
 *
 *  @return 加密后的数据
 */
- (NSData *)aes256EncryptWithKey:(NSString *)key;


/**
 *  AES256解密
 *
 *  @param key 键
 *
 *  @return 解密后的数据
 */
- (NSData *)aes256DecryptWithkey:(NSString *)key;


/**
 *  AES128加密
 *
 *  @param key 键
 *
 *  @return 加密后的数据
 */
- (NSData *)aes128EncryptWithkey:(NSString *)key;

/**
 *  AES128解密
 *
 *  @param key 键
 *
 *  @return 解密后的数据
 */
- (NSData *)aes128DecryptWithkey:(NSString *)key;


/**
 *  将NSData转换utf8格式的字符串
 *
 *  @return utf8格式的字符串
 */
- (NSString *)utf8String;


/**
 *  将NSData转换成一个base64格式的字符串
 *
 *  @return 字符串
 */
- (NSString *)base64Encoding;


/**
 *  将base64编码的字符串转换成NSData
 *
 *  @param base64Encoding base64编码过的字符串
 *
 *  @return NSData
 */
+ (NSData *)dataWithBase64Encoding:(NSString *)base64Encoding;



/**
 *  返回一个json格式的对象，如果不是json格式，则返回nil
 *
 *  @return json对象，或nil
 */
- (id)jsonValueDecoded;



/**
 *  根据文件名获取文件里数据
 *
 *  @param name 文件名
 *
 *  @return 文件里的数据
 */
- (NSData *)dataNamed:(NSString *)name;

/**
 *  保存到附件
 *
 *  @param key key
 */
- (void)save2File:(NSString *)key;


@end
