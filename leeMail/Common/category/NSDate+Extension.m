//
//  NSDate+Extension.m
//  yiqi
//
//  Created by 戢俊龙 on 2018/8/16.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)dateStr{
   
    return [self getUTCFormateLocalDate:self];
    
}
//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
- (NSString *)getUTCFormateLocalDate:(NSDate *)Date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:Date];
    return dateString;
}

+ (NSDate *)currentDate{
    
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSLog(@"%@", localeDate);
    
    return localeDate;
    
}
- (NSDate *)timeZoneDate{
    
    NSTimeZone *timeZone=[NSTimeZone timeZoneForSecondsFromGMT:8];
    NSInteger seconds=[timeZone secondsFromGMTForDate:self];
    NSDate *newDate=[self dateByAddingTimeInterval:seconds];
    return newDate;
}

- (NSDate *)yearMonthDayDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *currentDateString = [dateFormatter stringFromDate:self];
    NSDate *onlyDate = [dateFormatter dateFromString:currentDateString];
    return onlyDate;
}
- (NSInteger)yq_year{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitYear;
    currentCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:self];
    NSInteger year = [dataCom year];
    return year;
}
- (NSInteger)yq_month{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitMonth;
    currentCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:self];
    NSInteger month = [dataCom month];
    return month;
}
- (NSInteger)yq_day{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitDay;
    currentCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:self];
    NSInteger day = [dataCom day];
    return day;
}
- (NSInteger)yq_hour{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSUInteger integer = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
   currentCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:self];
    NSInteger hour = [dataCom hour];
    return hour;
}
- (NSInteger)yq_minute{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitMinute;
    currentCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:self];
    NSInteger minute = [dataCom minute];
    return minute;
}
- (NSInteger)yq_second{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitSecond;
    currentCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:self];
    NSInteger second = [dataCom second];
    return second;
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

+(NSDate *)dateWithStringDate:(NSString *)dateStr{
    
    
    NSDate *resultDate;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    
    formatter.timeZone = sourceTimeZone;
    
    
    resultDate = [formatter dateFromString:[NSString stringWithFormat:@"%@",dateStr]];
    
    
    return resultDate;
}

@end
