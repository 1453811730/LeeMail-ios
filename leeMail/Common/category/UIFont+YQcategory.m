//
//  UIFont+YQcategory.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "UIFont+YQcategory.h"

@implementation UIFont (YQcategory)



+(UIFont*)YQfont23{
    return [UIFont systemFontOfSize:23];
}

+(UIFont*)YQfont20{
    return [UIFont systemFontOfSize:23];
}

+(UIFont*)YQfont18 {
    return [UIFont systemFontOfSize:18];
}

+(UIFont*)YQfont17{
    return [UIFont systemFontOfSize:17];
}

+(UIFont*)YQfont16{
    return [UIFont systemFontOfSize:16];
}

+(UIFont*)YQfont15{
    return [UIFont systemFontOfSize:15];
}

+(UIFont*)YQfont14{
    return [UIFont systemFontOfSize:14];
}

+(UIFont*)YQfont13{
    return [UIFont systemFontOfSize:13];
}

+(UIFont*)YQfont12{
    return [UIFont systemFontOfSize:12];
}

+(UIFont*)YQfont11{
    return [UIFont systemFontOfSize:11];
}


+ (UIFont*)YQboldFont12 {
    return [UIFont YQboldFont:12];
}
+ (UIFont*)YQboldFont13  {
    return [UIFont YQboldFont:13];
}
+ (UIFont*)YQboldFont14  {
    return [UIFont YQboldFont:14];
}
+ (UIFont*)YQboldFont15 {
    return [UIFont YQboldFont:15];
}
+ (UIFont*)YQboldFont16  {
    return [UIFont YQboldFont:16];
}
+ (UIFont*)YQboldFont17  {
    return [UIFont YQboldFont:17];
}
+ (UIFont*)YQboldFont18  {
    return [UIFont YQboldFont:18];
}
+ (UIFont*)YQboldFont20  {
    return [UIFont YQboldFont:20];
}
+ (UIFont*)YQboldFont24  {
    return [UIFont YQboldFont:24];
}
+ (UIFont*)YQboldFont:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size];
}

+ (UIFont*)YQCustomFont12{
    return [UIFont YQCustomFont:12];
}
+ (UIFont*)YQCustomFont13 {
    return [UIFont YQCustomFont:13];
}
+ (UIFont*)YQCustomFont14 {
    return [UIFont YQCustomFont:14];
}
+ (UIFont*)YQCustomFont15 {
    return [UIFont YQCustomFont:15];
}
+ (UIFont*)YQCustomFont16 {
    return [UIFont YQCustomFont:16];
}
+ (UIFont*)YQCustomFont17 {
    return [UIFont YQCustomFont:17];
}
+ (UIFont*)YQCustomFont18 {
    return [UIFont YQCustomFont:18];
}
+ (UIFont*)YQCustomFont20 {
    return [UIFont YQCustomFont:20];
}
+ (UIFont*)YQCustomFont24 {
    return [UIFont YQCustomFont:24];
}

+ (UIFont*)YQCustomFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFang-SC-Regular" size:size];
}

+ (UIFont*)YQCustomBoldFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFang-SC-Bold" size:size];
}



@end




