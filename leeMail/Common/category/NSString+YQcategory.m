//
//  NSString+YQcategory.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "NSString+YQcategory.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+YQcategory.h"
#import <sys/utsname.h>

@implementation NSString (YQcategory)

///计算单行文字的size,font:字体
- (CGSize)ss_sizewithFont:(UIFont *)font{
    return [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}
///计算多行文字的size，font:字体
- (CGSize)ss_boundingRectwithSize:(CGSize)size withFont:(UIFont *)font{
    CGRect rect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect.size;
}

///设置不同的字体大小带有字号(用于金额显示)
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range with:(CGFloat)font1 andRange:(NSRange)secondRange with:(CGFloat)font2{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font1] range:range];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font2] range:secondRange];
    [attriStri addAttribute:NSForegroundColorAttributeName value:[UIColor YQmoneyColor] range:NSMakeRange(0, self.length)];
    return attriStri;
}
///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange and:(CGFloat)font2 with:(UIColor*)color2{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:range];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:range];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font2] range:secondRange];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color2 range:secondRange];
    if ((secondRange.length + secondRange.location) < self.length) {
        [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
        [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
    }
    
    return attriStri;
}
///设置不同的字号及颜色
- (NSMutableAttributedString*)ss_stringWithRange:(NSRange)range andFont:(UIFont*)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange and:(UIFont*)font2 with:(UIColor*)color2{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:font1 range:range];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:range];
    [attriStri addAttribute:NSFontAttributeName value:font2 range:secondRange];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color2 range:secondRange];
    if ((secondRange.length + secondRange.location) < self.length) {
        [attriStri addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
        [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
    }
    
    return attriStri;
}

///设置不同的字体大小
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andRange:(NSRange)secondRange{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:secondRange];
//    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(secondRange.location+secondRange.location, self.length-secondRange.location-secondRange.length)];
    [attriStri addAttribute:NSForegroundColorAttributeName value:[UIColor YQmoneyColor] range:NSMakeRange(0, self.length)];
    
    return attriStri;
}
///设置不同的字体大小并加粗体
- (NSMutableAttributedString*)ss_strBoldAttriWithRange:(NSRange)range andRange:(NSRange)secondRange{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:secondRange];
    [attriStri addAttribute:NSForegroundColorAttributeName value:[UIColor YQmoneyColor] range:NSMakeRange(0, self.length)];
    return attriStri;
}
///设置不同的颜色
- (NSMutableAttributedString*)ss_strColorWithRange:(NSRange)range{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSForegroundColorAttributeName value:[UIColor YQredColor] range:range];
    [attriStri addAttribute:NSForegroundColorAttributeName value:[UIColor YQtitleColor51] range:NSMakeRange(range.location + range.length, self.length-range.length)];
    return attriStri;
}
///设置不同的颜色
- (NSMutableAttributedString*)ss_strColorWithRange:(NSRange)range and:(UIColor*)color{
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSForegroundColorAttributeName value:[UIColor YQredColor] range:range];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location + range.length, self.length-range.length)];
    return attriStri;
}

///判断是否包含表情字符;YES:包含
- (BOOL)ss_stringContainsEmoji{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar high = [substring characterAtIndex: 0];
                              
                              // Surrogate pair (U+1D000-1F9FF)
                              if (0xD800 <= high && high <= 0xDBFF) {
                                  const unichar low = [substring characterAtIndex: 1];
                                  const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                  
                                  if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                      returnValue = YES;
                                  }
                                  
                                  // Not surrogate pair (U+2100-27BF)
                              } else {
                                  if (0x2100 <= high && high <= 0x27BF){
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}


#pragma ---------base64----------
+ (NSString *)stringWithBase64EncodedString:(NSString *)string{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString{
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData{
    return [NSData dataWithBase64EncodedString:self];
}

///MD5加密
- (NSString *)ss_MD5String{
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

#pragma mark ------------- 当前应用qpp信息 --------
///当前app名称
+ (NSString*)ss_appName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
///当前app版本号（1.0.1）
+ (NSString*)ss_versionForApp{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark ------------- 当前设备信息 -------------
///系统版本号
+ (NSString*)ss_getVersion{
    return [[UIDevice currentDevice] systemVersion];
}
///设备型号
+ (NSString *)ss_getIphoneType {
    //需要导入头文件：#import <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    return platform;
}





@end
