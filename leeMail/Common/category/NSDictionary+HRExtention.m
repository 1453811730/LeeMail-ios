//
//  NSDictionary+HRExtention.m
//  博金贷
//
//  Created by 何发松 on 16/5/9.
//  Copyright © 2016年  HeRay . All rights reserved.
//

#import "NSDictionary+HRExtention.h"
#import "NSString+HRExtension.m"


@implementation NSDictionary (HRExtention)
- (id)objectForDictKey:(id)key{
    if ([self isKindOfClass:[NSNull class]] || self == nil || self == NULL) {
        return @"";
    }
    if (!self) {
        return @"";
    }
    if (!key) {
        return @"";
    }
    NSArray *keys = [self allKeys];
    if (![keys containsObject:key]) {
        return @"";
    }
    id obj  = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return obj;
}

- (NSString *)dictionryToJSONString{
    NSError *parseError;
    NSData *parseData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (!parseData || parseError) {
        return @"";
    }
    NSString *jsonString = [[NSString alloc] initWithData:parseData encoding:NSUTF8StringEncoding];
    return jsonString;
//    NSArray *keys = self.allKeys;
//    NSArray *values = [keys sortedArrayUsingSelector:@selector(compare:) ];
//    NSMutableArray *objs = [NSMutableArray arrayWithCapacity:0];
//    for (NSString *key in keys) {
//        NSString *str = [NSString stringWithFormat:@"%@:%@",key,[self objectForKey:key]];
//        [objs addObject:str];
//    }
//    return [NSString stringWithFormat:@"{%@}",[objs componentsJoinedByString:@","]];
}


- (NSData *)transferToData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

- (NSString *)dateStringWithFormat:(NSString *)format{
    NSInteger time = [[self objectForDictKey:@"time"] integerValue]/1000;
    if (time == 0) {
        return @"";
    }
    NSString *date = [[NSString stringWithFormat:@"%ld",(long)time] dateTransferWithFormat:format];
    
    return date;
}

- (NSString *)dateString{
    NSInteger time = [[self objectForDictKey:@"time"] integerValue]/1000;
    if (time == 0) {
        return @"";
    }
    NSString *date = [[NSString stringWithFormat:@"%ld",(long)time] timestampTransferToDateString];
    return date;
}

- (NSDictionary *)deleteEmptyValue{
    NSMutableDictionary *dict = self.mutableCopy;
    NSArray *keys = [dict allKeys];
    for (NSString *key in keys) {
        id value = [dict objectForKey:key];
        if ([YQhelper isObjNil:value]) {
            [dict removeObjectForKey:key];
        }
    }
    return dict;
}
@end
