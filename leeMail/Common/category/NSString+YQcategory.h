//
//  NSString+YQcategory.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YQcategory)

///计算单行文字的size,font:字体
- (CGSize)ss_sizewithFont:(UIFont *)font;
///计算多行文字的size，font:字体
- (CGSize)ss_boundingRectwithSize:(CGSize)size withFont:(UIFont *)font;

///设置不同的字体大小带有字号(用于金额显示)
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range with:(CGFloat)font1 andRange:(NSRange)secondRange with:(CGFloat)font2;
///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange and:(CGFloat)font2 with:(UIColor*)color2;
///设置不同的字号及颜色
- (NSMutableAttributedString*)ss_stringWithRange:(NSRange)range andFont:(UIFont*)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange and:(UIFont*)font2 with:(UIColor*)color2;
///设置不同的字体大小
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andRange:(NSRange)secondRange;
///设置不同的字体大小并加粗体
- (NSMutableAttributedString*)ss_strBoldAttriWithRange:(NSRange)range andRange:(NSRange)secondRange;
///设置不同的颜色
- (NSMutableAttributedString*)ss_strColorWithRange:(NSRange)range;
///设置不同的颜色
- (NSMutableAttributedString*)ss_strColorWithRange:(NSRange)range and:(UIColor*)color;

///判断是否包含表情字符;YES:包含
- (BOOL)ss_stringContainsEmoji;

#pragma ---------base64----------
+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
- (NSData *)base64DecodedData;

///MD5加密
- (NSString *)ss_MD5String;


#pragma mark ------------- 当前应用qpp信息 --------
///当前app名称
+ (NSString*)ss_appName;
///当前app版本号（1.0.1）
+ (NSString*)ss_versionForApp;


@end
