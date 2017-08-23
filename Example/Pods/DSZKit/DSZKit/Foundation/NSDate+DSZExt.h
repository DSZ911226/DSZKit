//
//  NSDate+DSZExt.h
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HHmm              @"HH:mm"

#define HHmmss              @"HH:mm:ss"

#define MMdd                @"MM-dd"
#define MMdd1               @"MM/dd"
#define MMdd2               @"MM.dd"
#define MMdd3               @"MM月dd日"

#define MMddHHmm            @"MM-dd HH:mm"
#define MMddHHmm1           @"MM/dd HH:mm"
#define MMddHHmm2           @"MM.dd HH:mm"
#define MMddHHmm3           @"MM月dd日 HH:mm"

#define MMddHHmmss          @"MM-dd HH:mm:ss"
#define MMddHHmmss1         @"MM/dd HH:mm:ss"
#define MMddHHmmss2         @"MM.dd HH:mm:ss"
#define MMddHHmmss3         @"MM月dd日 HH:mm:ss"

#define YYYYMMdd            @"YYYY-MM-dd"
#define YYYYMMdd1           @"YYYY/MM/dd"
#define YYYYMMdd2           @"YYYY.MM.dd"
#define YYYYMMdd3           @"YYYY年MM月dd日"

#define YYYYMMddHHmm        @"YYYY-MM-dd HH:mm"
#define YYYYMMddHHmm1       @"YYYY/MM/dd HH:mm"
#define YYYYMMddHHmm2       @"YYYY.MM.dd HH:mm"
#define YYYYMMddHHmm3       @"YYYY年MM月dd日 HH:mm"
#define YYYYMMddHHmm4       @"YYYYMMddHHmm"

#define YYYYMMddHHmmss      @"YYYY-MM-dd HH:mm:ss"
#define YYYYMMddHHmmss1     @"YYYY/MM/dd HH:mm:ss"
#define YYYYMMddHHmmss2     @"YYYY.MM.dd HH:mm:ss"
#define YYYYMMddHHmmss3     @"YYYY年MM月dd日 HH:mm:ss"
#define YYYYMMddHHmmss4       @"YYYYMMddHHmmss"

typedef enum : NSUInteger {
    AddYears,
    AddMonths,
    AddWeaks,
    AddDays,
    AddHours,
    AddMinutes,
    AddSeconds,
} AddDateType;

@interface NSDate (DSZExt)

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;  // 季度
@property (nonatomic, readonly) BOOL isLeapMonth;   // 是否闰月
@property (nonatomic, readonly) BOOL isLeapYear;    // 是否闰年

/**
 距离现在多少时间之后

 @param num 时间长度
 @param dateType 时间类型 年／月／日／时／分／秒
 @return 日期
 */
- (NSDate *)dateByAddNum:(NSInteger)num dateType:(AddDateType)dateType;

/**
 *  将日期以格式化的方式转化成字符串
 *
 *  @param format 格式化字符串
 *
 *  @return 格式化后的日期
 */
- (NSString *)stringWithDateFormat:(NSString *)format;


/**
 *  将 日期字符串 通过 格式化 转换成 时间对象
 *
 *  @param dataString 时间字符串
 *  @param format     格式化字符串
 *
 *  @return 时间对象
 */
+ (NSDate *)dataWithString:(NSString *)dataString format:(NSString *)format;

/**
 距离现在多久之前

 @return 描述
 */
- (NSString *)prettyTimestampSinceDate;

/**
 *
 *  将时间分割成 年 月 日 时 分 秒
 *  @param date 传入的时间(必须是:yyyy-MM-dd HH:mm:ss)
 *
 *  @return @{@"year":年,@"month":月,@"day":日,@"hour":时,@"min":分,@"second":秒};
 */
+ (NSDictionary *)separatedDate:(NSDate *)date;

/**
 *  时间戳(秒)
 */
- (NSString *)timestamp;

/**
 *  时间戳(毫秒)
 */
- (NSString *)timestampMillisecond;

/**
 根据时间戳装换成日期字符串

 @param tamp 时间戳
 @param format 日期格式
 @return 日期字符串
 */
+ (NSString *)stringWithTamp:(NSTimeInterval)tamp format:(NSString *)format;

/**
 比较两个时间大小
 
 @param aDate a时间
 @param bDate b时间
 @return 大小结果
 */
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;



/**
 获取距离当天N天的日期，该日期为0点

 @param day N天, 0表示当天, -1表示前一天  1表示后一天
 @return 某一天零点的日期
 */
+ (NSDate *)zeroTimeOfDay:(NSInteger)day;

@end
