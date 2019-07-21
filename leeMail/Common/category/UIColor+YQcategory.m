//
//  UIColor+YQcategory.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "UIColor+YQcategory.h"

@implementation UIColor (YQcategory)

///标题颜色
+ (UIColor*)YQtitleColor51{
    return [UIColor YQcolorWithR:51 G:51 B:51];
}
///子标题颜色
+ (UIColor*)YQsubTitleColor136{
    return [UIColor YQcolorWithR:153 G:153 B:153];
}

+ (UIColor*)YQcolor71{
    return [UIColor YQcolorWithR:71 G:71 B:71];
}
+ (UIColor*)YQcolor110{
    return [UIColor YQcolorWithR:110 G:110 B:110];
}

///主要的红色
+ (UIColor*)YQredColor{
    return [UIColor YQcolorWithR:255 G:190 B:0];
}
//+ (UIColor*)YQredColor{
//    return [UIColor YQcolorWithR:233 G:59 B:61];
//}


///金额数的字体颜色
+ (UIColor*)YQmoneyColor{
    return [UIColor YQcolorWithHexString:@"#856020"];;
}

///自定义蓝色
+ (UIColor*)YQBlueColor{
    return [UIColor YQcolorWithR:0 G:112 B:201];
}

///table的分区背景色
+ (UIColor*)YQsectionColor{
    return [UIColor YQcolorWithR:244 G:244 B:244];
}

///borderColor(浅灰)
+ (UIColor*)YQborderColor{
    return [UIColor YQcolorWithR:178 G:178 B:178];
}
///分割线颜色
+ (UIColor*)YQseparatorColor{
    return [UIColor YQcolorWithR:237 G:237 B:237];
}


+(UIColor*)YQcolorWithR:(NSInteger)interR G:(NSInteger)interG B:(NSInteger)interB{
    return [UIColor colorWithRed:interR/255.0 green:interG/255.0 blue:interB/255.0 alpha:1];
}

///十六进制颜色
+ (UIColor *) YQcolorWithHexString: (NSString *)colorString {
    return [UIColor YQcolorWithHexString:colorString andAlpha:1];
}
///十六进制颜色带透明度值
+ (UIColor *) YQcolorWithHexString: (NSString *)colorString andAlpha:(CGFloat)alpha {
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

///黑色
+ (UIColor *) YQcolorWithHex000000 {
    return [UIColor YQcolorWithHexString:@"#000000" andAlpha:1];
}
///深灰
+ (UIColor *) YQcolorWithHex010101 {
    return [UIColor YQcolorWithHexString:@"#010101" andAlpha:1];
}
///浅灰
+ (UIColor *) YQcolorWithHex999999 {
    return [UIColor YQcolorWithHexString:@"#999999" andAlpha:1];
}

+ (UIColor *) YQcolorWithHex666666 {
    return [UIColor YQcolorWithHexString:@"#666666" andAlpha:1];
}

+ (UIColor *) YQcolorWithHex333333 {
    return [UIColor YQcolorWithHexString:@"#333333" andAlpha:1];
}

+ (UIColor *) YQcolorWithHexCCCCCC {
    return [UIColor YQcolorWithHexString:@"#CCCCCC" andAlpha:1];
}

///完成/确定按钮背景色
+ (UIColor *) YQbtncolorHex {
    return [UIColor YQcolorWithHexString:@"#C2AB82" andAlpha:1];
}

///shadow边缘阴影颜色
+ (UIColor*) YQshadowColor {
    return [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
}

@end
