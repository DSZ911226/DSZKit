//
//  DSZSSKeychain+DSZExt.h
//  DSZKit 存储最常用的数据, 数据是存储在系统密钥中
//
//  Created by 胡浩 on 2017/6/9.
//
//

#import "DSZSSKeychain.h"


@interface DSZSSKeychain (DSZExt)


/**
 登录Token

 @return 返回当前用户登录信息
 */
+ (NSString *)accessToken;


/**
 登录账号名
 
 @return 返回登录账户名
 */
+ (NSString *)accountName;


/**
 对服务端API访问的ip地址

 @return 当前IP
 */
+ (NSString *)ipAddress;


/**
 设置token

 @param accessToken 用户token
 @return 设置是否成功
 */
+ (BOOL)setAccessToken:(NSString *)accessToken;



/**
 设置账号名

 @param name 账户名
 @return 是否保存成功
 */
+ (BOOL)setAccountName:(NSString *)name;

/**
 设置对服务端API访问的ip地址

 @param ipAddress IP地址
 @return 返回是否设置成功
 */
+ (BOOL)setIPAddress:(NSString *)ipAddress;


/**
 删除token

 @return 删除token
 */
+ (BOOL)deleteAccessToken;



/**
 删除对服务端API访问的ip地址

 @return 是否删除成功
 */
+ (BOOL)deleteIPAddress;



@end
