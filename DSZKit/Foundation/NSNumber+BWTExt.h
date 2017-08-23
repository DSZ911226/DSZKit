//
//  NSNumber+BWTExt.h
//  BWT
//
//  Created by HuHao on 15/10/2.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (BWTExt)

/**
 *  根据字符串转换成NSNumber
 *
 *  @param string 字符串
 *
 *  @return NSNumber or Nil
 */
+ (NSNumber *)numberWithString:(NSString *)string;

/**
 *  获取Number数组
 *
 *  @param startIndex i的初始值
 *  @param endIndex   最大值
 *  @param multiple   倍数
 *
 *  @return 返回的数组
 */
+ (NSMutableArray *)startIndex:(NSInteger)startIndex
                      endIndex:(NSInteger)endIndex
                      multiple:(NSInteger)multiple;

/**
 *  NSNumber最多保留两位小数
 *
 *  @return 处理过后的字符串
 */
+ (NSString *)stringWithFormatFloatDigits:(NSNumber *)number;

/**
 *  NSNumber最多保留两位小数
 *
 *  @return 处理过后的字符串
 */
+ (NSString *)stringWithFormatDoubleDigits:(NSNumber *)number;


@end