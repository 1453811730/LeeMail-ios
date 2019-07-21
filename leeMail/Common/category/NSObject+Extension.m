//
//  NSObject+Extension.m
//  yiqi
//
//  Created by 戢俊龙 on 2018/11/15.
//  Copyright © 2018 qiyu. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (void)setDataWithDic:(NSDictionary *)dic
{
    for (NSString* key in [dic allKeys]) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            NSString* value = [dic objectForKey:key];
            if (![self isNOTNull:value]) {
                value = @"";
            }

            [self setValue:value forKey:key];
        }
    }
}

-(BOOL)isNOTNull:(id)object
{
    if (object==nil) {
        return NO;
    }else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }else if ([object isEqual:[NSNull null]]){
        return NO;
    }else if ([object isKindOfClass:[NSString class]]){
        NSString* target = object;
        if ([target isEqualToString:@"<null>"] || [target isEqualToString:@"(null)"]) {
            return NO;
        }
    }
    return YES;
}
@end
