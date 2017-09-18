//
//  NSString+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "DSZKitMacro.h"
#import <UIKit/UIKit.h>


@interface NSString (DSZExt)




/**
 *  随机生成一个UUID
 *
 *  @return UUID
 */
+ (NSString *)stringWithUUID;



/**
 *  将字符串MD5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5String;



/**
 * RSA解密
 */
+ (NSString *)decryptString:(NSString *)signature DSZDEPRECATED(1_13);

/**
 * 随机批次号，有当前时间，服务端共用参数使用
 当前方法已经废弃, 请使用DSZNetTools sequence方法
 */
+ (NSString *)sequence DSZDEPRECATED(1_13);


/**
 * 返回16位随机字符串
 */
+ (NSString *)random16;

/**
 *  16进制字符串转换成10进制字符串
 *
 *  @return 十进制的字符串
 */
- (NSString *)hexToString;


/**
 *  10进制字符串转换成16进制字符串
 *
 *  @return 加密后的字符串
 */
- (NSString *)stringToHex;


/**
 *  对字符串进行aes256加密 , 256的服务端解析失败，暂时用128
 *  @params key 加密key
 *  @return 加密后的字符串
 */
- (NSString *)aes256Encrypt:(NSString *)key;

/**
 *  进行aes256解密, 256的服务端解析失败，暂时用128
 *  @params key 加密key
 *  @return 解密后的字符串
 */
- (NSString *)aes256Decrypt:(NSString *)key;


/**
 *  对字符串进行aes128加密
 *  @params key 加密key
 *  @return 加密后的字符串
 */
- (NSString *)aes128Encrypt:(NSString *)key;

/**
 *  进行aes128解密
 *  @params key 加密key
 *  @return 解密后的字符串
 */
- (NSString *)aes128Decrypt:(NSString *)key;

/**
 *  将字符串以base64编码
 *
 *  @return 编码后的字符串
 */
- (NSString *)base64Encoding;


/**
 *  将base64编码格式的字符串还原成明文字符串
 *
 *  @param base64String base64编码过的字符串
 *
 *  @return 明文字符串
 */
+ (NSString *)base64Decode:(NSString *)base64String;


/**
 *  将字符串以URL编码, 编码格式为UTF8
 *
 *  @return 编码后的字符串
 */
- (NSString *)stringByURLEncode;


/**
 *  将字符串以URL编码
 *
 *  @param encoding 编码格式
 *
 *  @return 编码后的字符串
 */
- (NSString *)stringByURLEncode:(NSStringEncoding)encoding;



/**
 *  根据字符串内容、字体大小、视图最大范围、lineBreakMode（换行模型） 计算出当前字符串所对应的视图大小
 *
 *  @param font          字体大小
 *  @param size          视图最大范围
 *  @param lineBreakMode NSLineBreakMode
 *          NSLineBreakByCharWrapping; 以字符为显示单位显示，后面部分省略不显示。
            NSLineBreakByClipping; 剪切与文本宽度相同的内容长度，后半部分被删除。
            NSLineBreakByTruncatingHead; 前面部分文字以……方式省略，显示尾部文字内容。
            NSLineBreakByTruncatingMiddle; 中间的内容以……方式省略，显示头尾的文字内容。
            NSLineBreakByTruncatingTail; 结尾部分的内容以……方式省略，显示头的文字内容。
            NSLineBreakByWordWrapping; 以单词为显示单位显示，后面部分省略不显示。
 *  @return 视图大小
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 判断是否纯汉字
 
 @return YES:是，NO：否
 */
- (BOOL)isChinese;


/**
 *  根据字体大小计算出视图宽度
 *
 *  @param font 字体
 *
 *  @return 视图宽度
 */
- (CGFloat)widthForFont:(UIFont *)font;


/**
 *  根据字体大小，宽度 计算出 视图高度
 *
 *  @param font  字体
 *  @param width 宽度
 *
 *  @return 视图高度
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;


/**
 *  正则匹配
 *
 *  @param regex 正则表达式
 *
 *  @return YES-匹配 NO-不匹配
 */
- (BOOL)matchesRegex:(NSString *)regex;


/**
 *  将字符串过滤空格
 *
 *  @return 过滤空格后的字符串
 */
- (NSString *)stringByTrim;

/**
 *  去除一个String里面的空格跟换行
 *
 *  @return 过滤后的字符串
 */
- (NSString *)clearWhiteSpaceAndNewLine;


/**
 *  判断是否包含某个字符串
 *
 *  @param string 需要被匹配的字符串
 *
 *  @return YES-匹配 NO-不匹配
 */
- (BOOL)containsString:(NSString *)string;

/**
 *  同containsString
 *
 *  @param set 字符集合
 *
 *  @return YES-匹配 NO-不匹配
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;


/**
 *  将字符串转成NSNumber
 *
 *  @return NSNumber or Nil
 */
- (NSNumber *)numberValue;


/**
 *  将字符串转换成NSData类型
 *
 *  @return NSData or Nil
 */
- (NSData *)dataValue;

/**
 *  将字符串转换成json对象
 *
 *  @return json对象 or Nil
 */
- (id)jsonValueDecoded;


/**
 *  验证是否正确的邮箱格式
 *
 *  @return YES-正确  NO-不正确
 */
- (BOOL)isValidateEmail;


/**
 *  验证身份证格式是否正确
 *
 *  @return YES-正确 NO-不正确
 */
- (BOOL)isValidateIDCard;


/**
 *  验证验证码格式是否正确
 *
 *  @return YES-正确 NO-不正确
 */
- (BOOL)isValidVerifyCode;


/**
 *  验证手机号码格式是否正确
 *
 *  @return YES-正确 NO-不正确
 */
- (BOOL)isMobileNumber;


/**
 *  验证是否为纯数字
 *
 *  @return YES-是 NO-不是
 */
- (BOOL)isNumber;

/**
 *  验证是否为money类型
 *
 *  @return YES-是 NO-不是
 */
- (BOOL)isMoney;


/**
 *  将unicode编码格式字符串的转换成中文
 *
 *  @return 带中文的字符串
 */
- (NSString *)replaceUnicode;

/**
 *  将 固定的表情格式转换成文字展现
 *  举例： {:001:} 替换成 [表情]
 *  @return NSString
 */
- (NSString *)replaceExpression:(NSString *)string;




/**
 根据相对路径得到绝对路径
 #warning 当前对象是相对路径
 @return 相对路径
 */
- (NSString *)absolutePath;


/**
 验证是否符合正则

 @param regex 正则表达式
 @return 是否通过 NO-未通过 YES-通过
 */
- (BOOL)isValidateByRegex:(NSString *)regex;


/**
 *  手机号分服务商
 *
 *  @return 服务商
 */
- (BOOL)isMobileNumberClassification;


/**
 校验是否为邮箱

 @return YES-是 NO-否
 */
- (BOOL)isEmailAddress;


/**
 校验是否身份证号

 @return YES-是 NO-否
 */
- (BOOL)simpleVerifyIdentityCardNum;


/**
 校验是否车牌号

 @return YES-是 NO-否
 */
- (BOOL)isCarNumber;


/**
 校验是否Mac地址

 @return YES-是 NO-不是
 */
- (BOOL)isMacAddress;


/**
 校验是否URL

 @return YES-是 NO-否
 */
- (BOOL)isValidUrl;


/**
 校验是否中文

 @return YES-是 NO-否
 */
- (BOOL)isValidChinese;


/**
 校验是否邮政编码

 @return YES-是 NO-否
 */
- (BOOL)isValidPostalcode;


- (BOOL)isValidTaxNo;

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

#pragma mark - 算法相关
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;



/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)bankCardluhmCheck;


- (BOOL)isIPAddress;


/**
 sha1加密方式

 @return string
 */
- (NSString *)sha1;

@end
