//
//  NSString+HRExtension.h
//  博金贷
//
//  Created by 何发松 on 16/4/6.
//  Copyright © 2016年  HeRay . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HRExtension)
///验证银行卡号
- (BOOL)isValidateBankCardNO;
///验证手机号
- (BOOL)isMobileNumber;
- (BOOL)isNumOrZimu;
///验证身份证号
- (BOOL)isValidateIdentityId;

- (BOOL)checkChineseWords;
-(NSNumber *)noFromString;
-(NSString *)numberStringFromString;
- (BOOL)isRemoteUrl;
///判断是否为空
- (BOOL)empty;
- (NSURL *)formatUrl;
- (UIImage *)imageFromImgName;

/**
 *  格式化金额字符串，小数点前每三位之间加,
 *
 *  @return 格式化后的字符串
 */
- (NSString *)formatMoneyString;


- (NSDictionary *)dictionaryFromString;
/**
 *  格式化银行卡号 四位空格
 *
 *  @return 格式化后的字符串
 */
- (NSString *)bankCodeFormat;

- (BOOL)validateWithRedExpression:(NSString *)expression;

/**
 格式化金额字符串，不足万的显示原值，反之处理成以万为单位

 @return <#return value description#>
 */
- (NSString *)formatAmount;

/**
 将字符串中包含的h标签替换成p标签

 @return 结果字符串
 */
- (NSString *)stringByStrippingHTML;


/**
 去除字符串中的html标签

 @return 去除标签的字符串
 */
- (NSString *)stringByTrimmingHTMLCharacters;

/**
 根据字符串计算宽度

 @param size 容器大小
 @param attributions 参数，如字体大小等
 @param minimumWidth 默认宽度
 @return 计算之后的结果
 */
- (CGFloat)boundingWidth:(CGSize)size attributions:(NSDictionary *)attributions minimumWidth:(CGFloat)minimumWidth;
/**
 根据字符串计算高度
 
 @param size 容器大小
 @param attributions 参数，如字体大小等
 @param minimumHeight 默认高度
 @return 计算之后的结果
 */
- (CGFloat)boundingHeight:(CGSize)size attributions:(NSDictionary *)attributions minimumHeight:(CGFloat)minimumHeight;


/**
 性别值

 @return 性别描述
 */
- (NSString *)genderString;


/**
 时间戳转化成时间 格式yyyy-mm-dd

 @return 时间字符串
 */
- (NSString *)timestampTransferToDateString;

/**
 时间戳转化成时间 格式yyyy-mm-dd HH:mm
 
 @return 时间字符串
 */
- (NSString *)timestampTransferToDateStringshiFen;

/**
 将时间戳转化成规定格式的时间字符串

 @param dateFormat 时间格式
 @return 格式化的字符串
 */
- (NSString *)dateTransferWithFormat:(NSString *)dateFormat;

/**
 自定义时间错字典

 @return <#return value description#>
 */
- (NSDictionary *)formatTimestamp;

/**
 根据状态码获取状态值

 @return 状态值
 */
//- (NSString *)orderstatusFromValue;

/**
 判断是否是有效的金额

 @param decimalCount 有效小数
 @param max 最大值
 @return 判断结果
 */
- (BOOL)isValidateMoneyString:(NSInteger)decimalCount max:(CGFloat)max;

/**
 判断字符串中是否包含emoji表情

 @return 判断结果
 */
- (BOOL)stringContainsEmoji;

//url 获取参数
+(NSDictionary *)dictionaryWithUrlString:(NSString * __nullable)urlStr;

+ (BOOL)checkPrice:(NSString *)price;

@end
