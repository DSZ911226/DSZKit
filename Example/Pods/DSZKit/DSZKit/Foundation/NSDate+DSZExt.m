//
//  NSDate+DSZExt.m
//  DSZ
//
//  Created by DSZ on 15/10/2.
//  Copyright © 2015年 DSZ. All rights reserved.
//

#import "NSDate+DSZExt.h"

@implementation NSDate (DSZExt)

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    if ((year % 400 == 0) || (year % 100 == 0) || (year % 4 == 0)) return YES;
    return NO;
}

- (NSDate *)dateByAddNum:(NSInteger)num dateType:(AddDateType)dateType {
    if (dateType == AddYears || dateType == AddMonths || dateType == AddWeaks) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        if (dateType == AddYears) {
            [components setYear:num];
        }
        if (dateType == AddMonths) {
            [components setMonth:num];
        }
        if (dateType == AddWeaks) {
            [components setWeekOfYear:num];
        }
        return [calendar dateByAddingComponents:components toDate:self options:0];
    }
    if (dateType == AddDays || dateType == AddHours || dateType == AddMinutes || dateType == AddSeconds) {
        NSTimeInterval aTimeInterval = 0;
        if (dateType == AddDays) {
            aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * num;
        }
        if (dateType == AddHours) {
            aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * num;
        }
        if (dateType == AddMinutes) {
            aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * num;
        }
        if (dateType == AddSeconds) {
            aTimeInterval = [self timeIntervalSinceReferenceDate] + num;
        }
        NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
        return newDate;
    }
    return nil;
}

- (NSString *)stringWithDateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}


+ (NSDate *)dataWithString:(NSString *)dataString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dataString];
}

- (NSString *)prettyTimestampSinceDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDate *earliest = [self earlierDate:self];
    NSDate *latest = (earliest == self) ? self : self;
    NSDateComponents *components = [calendar components:unitFlags fromDate:earliest toDate:latest options:0];

    if (components.year >= 1) {
        return @"一年前";
    }
    if (components.month >= 1) {
        return [self stringForComponentValue:components.month withName:@"个月" andPlural:@"个月"];
    }
    if (components.weekOfMonth >= 1) {
        return [self stringForComponentValue:components.weekOfMonth withName:@"周" andPlural:@"周"];
    }
    if (components.day >= 1) {
        return [self stringForComponentValue:components.day withName:@"天" andPlural:@"天"];
    }
    if (components.hour >= 1) {
        return [self stringForComponentValue:components.hour withName:@"小时" andPlural:@"小时"];
    }
    if (components.minute >= 1) {
        return [self stringForComponentValue:components.minute withName:@"分钟" andPlural:@"分钟"];
    }
    return @"刚刚";
}


- (NSString *)stringForComponentValue:(NSInteger)componentValue
                            withName:(NSString*)name
                           andPlural:(NSString*)plural
{
    NSString *timespan = NSLocalizedString(componentValue == 1 ? name : plural, nil);
    return [NSString stringWithFormat:@"%ld%@%@", (long)componentValue, timespan, @"前"];
}

// 将时间分割成 年 月 日 时 分 秒
+ (NSDictionary *)separatedDate:(NSDate *)date {
    
    // 这一步重要,转化为字符串格式必须是:yyyy-MM-dd HH:mm:ss
    NSString *tempString = [date stringWithDateFormat:YYYYMMddHHmmss];
    
    NSArray *tempArray = [tempString componentsSeparatedByString:@" "];
    NSString *yearString = [tempArray firstObject];
    NSString *hourString = [tempArray lastObject];
    
    // 获得 年月日 和 时分秒 的数组
    NSArray *yearArray = [yearString componentsSeparatedByString:@"-"];
    NSArray *hourArray = [hourString componentsSeparatedByString:@":"];
    
    // 读取年月日(除非系统改变,否则yearArray和hourArray始终有三个)
    NSString *year = yearArray[0];
    NSString *month = yearArray[1];
    NSString *day = yearArray[2];
    
    // 读取时分秒
    NSString *hour = hourArray[0];
    NSString *min = hourArray[1];
    NSString *second = hourArray[2];
    
    // 将年月日时分秒 放入字典
    NSDictionary *dic = @{@"year":year,@"month":month,@"day":day,
                          @"hour":hour,@"min":min,@"second":second};
    
    return dic;
}

// 时间戳
- (NSString *)timestamp{
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",interval];
}

// 时间戳(毫秒)
- (NSString *)timestampMillisecond {
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",(interval * 1000)];
}

//时间戳转日期 用日期样式
+ (NSString *)stringWithTamp:(NSTimeInterval)tamp format:(NSString *)format {
    NSString *intervalStr = [NSString stringWithFormat:@"%f",tamp];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:[intervalStr doubleValue]/1000];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
    
}

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate{
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *dta = [[NSDate alloc] init];
    
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    
    dtb = [dateformater dateFromString:bDate];
    
    NSComparisonResult result = [dta compare:dtb];
    
    NSInteger a;
    
    if (result == NSOrderedSame) a = 0; //bDate = aDate
    
    else if (result == NSOrderedAscending) a = 1;//bDate比aDate大
    
    else a = 2;//bDate比aDate小
    
    return a;
}


+ (NSDate *)zeroTimeOfDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];

    NSDate *now = [NSDate new];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *today = [calendar dateFromComponents:components];
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitDay value:day toDate:today options:0];
    
    return date;
}

@end
