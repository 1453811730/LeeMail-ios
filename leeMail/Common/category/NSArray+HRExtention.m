//
//  NSArray+HRExtention.m
//  博金贷
//
//  Created by 何发松 on 16/5/10.
//  Copyright © 2016年  HeRay . All rights reserved.
//

#import "NSArray+HRExtention.h"

@implementation NSArray (HRExtention)
- (id)objectAtArrayIndex:(NSUInteger)index{
    if (!self.count) {
        return @"";
    }
    if (index >= self.count) {
        return @"";
    }
    return [self objectAtIndex:index];
}

- (NSData *)transferToData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

//数组转JSON字符串
- (NSString*)arrayToJSONString{
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:nil];
    if (data == nil) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
@end
