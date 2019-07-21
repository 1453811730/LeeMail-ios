//
//  UIColor+YQcategory.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YQcategory)

+ (UIColor*)YQcolorWithR:(NSInteger)interR G:(NSInteger)interG B:(NSInteger)interB;

///标题颜色
+ (UIColor*)YQtitleColor51;
///子标题颜色
+ (UIColor*)YQsubTitleColor136;

+ (UIColor*)YQcolor71;
+ (UIColor*)YQcolor110;

///金额数的字体颜色
+ (UIColor*)YQmoneyColor;

///自定义蓝色
+ (UIColor*)YQBlueColor;

///table的分区背景色
+ (UIColor*)YQsectionColor;

///主要的红色
+ (UIColor*)YQredColor;

///borderColor(浅灰)
+ (UIColor*)YQborderColor;

///分割线颜色
+ (UIColor*)YQseparatorColor;


///十六进制颜色
+ (UIColor *) YQcolorWithHexString: (NSString *)colorString;
///十六进制颜色带透明度值
+ (UIColor *) YQcolorWithHexString: (NSString *)colorString andAlpha:(CGFloat)alpha;
///黑色
+ (UIColor *) YQcolorWithHex000000;
///深灰
+ (UIColor *) YQcolorWithHex010101;
///浅灰
+ (UIColor *) YQcolorWithHex999999;
///666666
+ (UIColor *) YQcolorWithHex666666;
///333333
+ (UIColor *) YQcolorWithHex333333;

+ (UIColor *) YQcolorWithHexCCCCCC;

///完成/确定按钮背景色
+ (UIColor *) YQbtncolorHex;
///shadow边缘阴影颜色
+ (UIColor*) YQshadowColor;


@end
