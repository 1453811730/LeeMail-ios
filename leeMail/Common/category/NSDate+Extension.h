//
//  NSDate+Extension.h
//  yiqi
//
//  Created by 戢俊龙 on 2018/8/16.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

+ (NSDate *)currentDate;    ////解决时区问题的当前时间
- (NSDate *)timeZoneDate; //转换返回解决时区问题的Date
- (NSDate *)yearMonthDayDate; //只显示年月日,时分秒初始化为0
- (NSInteger)yq_year;
- (NSInteger)yq_month;
- (NSInteger)yq_day;
- (NSInteger)yq_hour;
- (NSInteger)yq_minute;
- (NSInteger)yq_second;

- (NSString *)dateStr;  //date转字符串

+(NSDate *)dateWithStringDate:(NSString *)dateStr; 
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;  //比较大小

@end

NS_ASSUME_NONNULL_END
