//
//  NSString+HRExtension.m
//  博金贷
//
//  Created by 何发松 on 16/4/6.
//  Copyright © 2016年  HeRay . All rights reserved.
//

#import "NSString+HRExtension.h"

@implementation NSString (HRExtension)
- (BOOL)isValidateBankCardNO{
    if (!self.length) {
        return NO;
    }
    if (self.length < 16) {
        return NO;
    }
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3|5|6|8|7|4)\\d{9}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
//    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
//    NSString *CU = @"^1(3[0-2]|5[256]|7[07]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
//    NSString * CT = @"^1([47])\\d{9}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
//        || ([regextestcm evaluateWithObject:self] == YES)
//        || ([regextestct evaluateWithObject:self] == YES)
//        || ([regextestcu evaluateWithObject:self] == YES)
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(BOOL)isNumOrZimu{
    for (int i = 0; i < self.length; i++) {
        int a = [self characterAtIndex:i];
        if ((a > 47 && a < 58) || (a > 64 && a < 91) || (a > 96 && a < 123)) {
            return YES;
        }
    }
    return NO;
}

/**
 *  验证密码是否包含中文、表情等特殊字符
 *
 *  @return 验证结果
 */
- (BOOL)checkChineseWords{

    for (int i = 0; i < self.length; i++) {
        int a = [self characterAtIndex:i];
        if (a > 126) {
            return YES;
        }
    }
    return NO;
}

/**
 *  根据验证规则分离字符串
 *
 *  @param input 待验证字符串
 *  @param set   验证规则NSCharacterSet
 *
 *  @return 数组，第一个元素为根据验证规则分离出的字符数组，第二个元素为根据有分离出字符串组成的NSCharacterSet
 */
- (NSArray *)analyseString:(NSString *)input character:(NSCharacterSet *)set{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSMutableCharacterSet *tmpSet = nil;
    for (int i = 0; i < input.length; i++) {
        NSString *str = [input substringWithRange:NSMakeRange(i, 1)];
        if (set) {
            NSRange range = [str rangeOfCharacterFromSet:set];
            if (range.location != NSNotFound) {
                [array addObject:str];
                if (tmpSet == nil) {
                    tmpSet = [NSMutableCharacterSet new];
                }
                [tmpSet addCharactersInString:str];
            }
        }else{
            [array addObject:str];
        }
    }
    if (!tmpSet) {
        return @[array];
    }
    return @[array,tmpSet];
}


-(NSNumber *)noFromString
{

    if (!self || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return nil;
    }
    NSNumberFormatter *format = [NSNumberFormatter new];
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [format numberFromString:self];
    return num;

}

/**
 *  格式化数字字符串，保留两位小数，并去除末尾的0
 *
 *  @return 格式化之后的字符串
 */
-(NSString *)numberStringFromString
{
    
    if (!self || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return self;
    }
    NSNumberFormatter *format = [NSNumberFormatter new];
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [format numberFromString:self];
    NSString *str = [NSString stringWithFormat:@"%0.2f",num.doubleValue];
    NSRange range = [str rangeOfString:@"."];
    if (range.location == !NSNotFound) {
        return self;
    }
    //去除末尾的0，获取剪切位置
    NSInteger loc = str.length ;
    for (NSInteger i = str.length - 1; i > range.location; i--) {
        int a = [str characterAtIndex:i];
        if (a == 48) {
            loc--;
        }else{
            break;
        }
    }
    str = [str substringToIndex:loc];
    //如果末尾为.去除末尾的.
    if ([str rangeOfString:@"."].location == str.length - 1) {
        return [str substringToIndex:str.length - 1];
    }
    return str;
}

- (NSString *)formatAmount{
    if ([self empty]) {
        return @"0";
    }
    double value = self.doubleValue;
    double result = value/10000.0;
    if (result >= 1.0) {
        return [[[NSString stringWithFormat:@"%0.2f",result] numberStringFromString] stringByAppendingString:@"万元"];
    }
    return [[[NSString stringWithFormat:@"%0.2f",value] numberStringFromString] stringByAppendingString:@"元"];
}

- (BOOL)isRemoteUrl
{
    if ([self empty]) {
        return NO;
    }
    if ([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

- (NSURL *)formatUrl{
    if ([self empty]) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    return url;
}

- (BOOL)empty
{
    if (!self || [self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return YES;
    }
    return NO;
}

- (UIImage *)imageFromImgName{
    if ([self empty]) {
        return nil;
    }
    NSRange range = [self rangeOfString:@"."];
    NSString *type = @".png";
    NSString *imgName = self;
    if (range.location != NSNotFound) {
        type = [self substringFromIndex:range.location ];
        imgName = [imgName substringToIndex:range.location ];
    }
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    return image;
}



- (NSString *)formatMoneyString{
    if ([self empty]) {
        return @"0";
    }
    NSArray *range = [[self numberStringFromString] componentsSeparatedByString:@"."];
    NSString *str = range[0];
    NSMutableArray *nums = [NSMutableArray arrayWithCapacity:0];
    int j = 0;
    for (NSInteger i = str.length - 1; i >= 0 ; i--) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        j++;
        [nums insertObject:s atIndex:0];
        if (j == 3  && i > 0) {
            [nums insertObject:@"," atIndex:0];
            j = 0;
        }
    }
    
    NSString *result = [nums componentsJoinedByString:@""];
    if (range.count == 2) {
        result = [result stringByAppendingFormat:@".%@",range[1]];
    }
    return result;
}


//将url地址中所带的参数转换为字典 格式k1=v1&k2=v2
- (NSDictionary *)dictionaryFromString{
    NSArray *compents = [self componentsSeparatedByString:@"&"];
    if (!compents.count) {
        return [NSDictionary dictionary];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    for (id obj in compents) {
        if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj containsString:@"="]) {
            NSString *str = (NSString *)obj;
            NSArray *strs = [str componentsSeparatedByString:@"="];
//            NSString *value = [[strs objectAtArrayIndex:1] empty] ? @"" : [strs objectAtArrayIndex:1];
            [params setObject:[strs objectAtArrayIndex:1] forKey:[strs objectAtArrayIndex:0]];
        }
    }
    return params;
}

- (NSString *)bankCodeFormat{
    if ([self empty]) {
        return @"";
    }
    if (self.length <=4) {
        return self;
    }
    NSMutableArray *charaters = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.length; i++) {
        NSString *charater = [self substringWithRange:NSMakeRange(i, 1)];
        [charaters addObject:charater];
        if (i%4 == 3) {
            [charaters addObject:@" "];
        }
    }
    return [charaters componentsJoinedByString:@""];
}

- (BOOL)isValidateIdentityId{
    if ([self empty]) {
        return NO;
    }
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}


- (NSString *)stringByStrippingHTML {
    if ([self empty]){
        return @"";
    }
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"h[12345]" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@"p style=\"font-weight:bold;font-size:12px;\""];
    return s;
}

- (BOOL)validateWithRedExpression:(NSString *)expression{
    if ([expression empty]) {
        return NO;
    }
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", expression];
    return [predicate evaluateWithObject: self];
}


- (NSString *)stringByTrimmingHTMLCharacters{
    if ([self empty]){
        return @"";
    }
    NSRange r;
    NSString *s = [[self stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (CGFloat)boundingWidth:(CGSize)size attributions:(NSDictionary *)attributions minimumWidth:(CGFloat)minimumWidth{
    if ([self empty]) {
        return minimumWidth;
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributions context:nil];
    return MAX(CGRectGetWidth(rect), minimumWidth);
}

- (CGFloat)boundingHeight:(CGSize)size attributions:(NSDictionary *)attributions minimumHeight:(CGFloat)minimumHeight{
    if ([self empty]) {
        return minimumHeight;
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributions context:nil];
    return MAX(CGRectGetHeight(rect), minimumHeight);
}


/**
 性别字符串

 @return 男/女
 */
- (NSString *)genderString{
    switch (self.integerValue) {
        case 0:
            return @"男";
        case 1:
            return @"女";
        default:
            return @"";
    }
}


/**
 时间戳转化成时间

 @return 时间字符串
 */
- (NSString *)timestampTransferToDateString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

/**
 时间戳转化成时间
 
 @return 时间字符串
 */
- (NSString *)timestampTransferToDateStringshiFen{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

- (NSString *)dateTransferWithFormat:(NSString *)dateFormat{
    if ([dateFormat empty]) {
        dateFormat = @"yyyy-MM-dd";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

- (NSDictionary *)formatTimestamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    NSTimeInterval interval = [date timeIntervalSince1970];
    return @{@"time":[NSNumber numberWithInteger:interval*1000]};
}

- (NSString *)orderstatusFromValue{
    switch (self.integerValue) {
        case 0:
            return @"未发布";
        case 1:
            return @"已发布抢标中";
        case 2:
            return @"已抢标待支付";
        case 3:
            return @"已支付成功";
        case 6:
            return @"已结单";
        case 5:
            return @"已预约待支付";
        case 7:
            return @"退款中";
        case 8:
            return @"已退款";
        case 9:
            return @"异常结单";
        case 10:
            return @"退款申请";
        case 11:
            return @"退单中";
        case 12:
            return @"退款失败";
        default:
            return @"";
    }
}

- (BOOL)isValidateMoneyString:(NSInteger)decimalCount max:(CGFloat)max{
    if ([self empty]) {
        return NO;
    }
    BOOL hasDot = [[self substringToIndex:self.length - 1] rangeOfString:@"."].location != NSNotFound;
    NSString *string = [self substringFromIndex:self.length - 1];
    if (hasDot && [string isEqualToString:@"."]) {
        [self presentMessageTips:@"只能输入一位小数点"];
        return NO;
    }
    if (hasDot && [self substringFromIndex:[[self substringToIndex:self.length - 1] rangeOfString:@"."].location].length > decimalCount) {
        DLog(@"%@",[self substringFromIndex:[self rangeOfString:@"."].location])
        
        [self presentMessageTips:@"只能保留两位小数"];
        return NO;
    }
    if (self.floatValue > max) {
        [self presentMessageTips:[NSString stringWithFormat:@"请输入小于%.1f的数字",max]];
        return NO;
    }
    return YES;
}

- (BOOL)stringContainsEmoji
{
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

+(NSDictionary *)dictionaryWithUrlString:(NSString * __nullable)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


+ (BOOL)checkPrice:(NSString *)price {
    
    NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数
    
    NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    
    BOOL flag = [money evaluateWithObject:price];
    return flag;
    
}


@end
