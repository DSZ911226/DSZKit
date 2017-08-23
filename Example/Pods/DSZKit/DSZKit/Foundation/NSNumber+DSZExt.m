//
//  NSNumber+DSZExt.m
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "NSNumber+DSZExt.h"
#import "NSObject+DSZExt.h"
#import "NSString+DSZExt.h"
#import "DSZKitMacro.h"

@implementation NSNumber (DSZExt)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(_isEqualToNumber:) tarClass:@"__NSCFNumber" tarSel:@selector(isEqualToNumber:)];
    });
}

- (BOOL)_isEqualToNumber:(NSNumber *)number {
    if (!number) {
        DSZErrorLog(@"number is nil");
        return NO;
    }
    
    return [self _isEqualToNumber:number];
}



+ (NSNumber *)numberWithString:(NSString *)string {
    NSString *str = [[string stringByTrim] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

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
                      multiple:(NSInteger)multiple {
    NSMutableArray  *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = startIndex ; i < endIndex+1; i++) {
        [tempArray addObject:@(i * multiple)];
    }
    return tempArray;
}

/**
 *  NSNumber最多保留两位小数
 *
 *  @return 处理过后的字符串
 */
+ (NSString *)stringWithFormatFloatDigits:(NSNumber *)number {
    
    if (!number) return @"0";
    NSArray *tempNumArr = [number.stringValue componentsSeparatedByString:@"."];
    // 如果是整数 tempNumArr.count = 1
    if (tempNumArr.count <= 1 ) return number.stringValue;
    
    NSString *tempNumStr = [tempNumArr lastObject];
    // 长度为零 代表是整数
    if (tempNumStr.length == 0) return number.stringValue;
    // 大于等于2 保留两位小数
    if (tempNumStr.length >= 2) return [NSString stringWithFormat:@"%.2f",number.doubleValue];
    // =1 一位小数
    return [NSString stringWithFormat:@"%.1f",number.doubleValue];
}

/**
 *  NSNumber最多保留两位小数
 *
 *  @return 处理过后的字符串
 */
+ (NSString *)stringWithFormatDoubleDigits:(NSNumber *)number {
  
  if (!number) return @"0";
  NSArray *tempNumArr = [number.stringValue componentsSeparatedByString:@"."];
  if (tempNumArr.count <= 1 ) {
    return number.stringValue;
  }
  NSString *tempNumStr = [tempNumArr lastObject];
  // 长度为零 代表是整数
  if (tempNumStr.length == 0) return number.stringValue;
  // 大于等于2 保留两位小数
  if (tempNumStr.length >= 2) return [NSString stringWithFormat:@"%.2f",number.doubleValue];
  // =1 一位小数
  return [NSString stringWithFormat:@"%.1f",number.doubleValue];
}


@end
