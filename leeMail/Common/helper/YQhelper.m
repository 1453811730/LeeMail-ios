//
//  YQhelper.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "YQhelper.h"
#import <sys/utsname.h>
#import "NSString+HRExtension.h"
//#import "YQbaseWebVC.h"
//#import "YQsearchBaseVC.h"
#import <GKPhotoBrowser.h>
#import <GKPhotoView.h>
//#import <RongIMKit/RongIMKit.h>
//#import <RongIMLib/RongIMLib.h>

///SCHEME 事件
//#import "YQshareDetailVC.h"
//#import "YQneedDetailVC.h"
//#import "YQcenterViewVC.h"
//#import "YQbaseNavigationC.h"
//#import "YQReceiptAddressListVC.h"

@implementation YQhelper {
    NSMutableDictionary *_fmtters;
}

+ (instancetype)shareHelp{
    static YQhelper* help = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        help = [[YQhelper alloc] init];
    });
    return help;
}

- (NSDateFormatter *)fmtterForStyle:(BPDateFormatterStyle)style{
    NSString *fmt = nil;
    switch (style) {
        case BPDateFormatterStyleDefault:
            fmt = @"yyyy-MM-dd HH:mm:ss";
            break;
        case BPDateFormatterStyle_2:
            fmt = @"yyyy/MM/dd HH:mm:ss";
            break;
        case BPDateFormatterStyle_3:
            fmt = @"yyyyMMddHHmmss";
            break;
        case BPDateFormatterStyle_4:
            fmt = @"yyyy-MM-dd";
            break;
        case BPDateFormatterStyle_5:
            fmt = @"yyyy年MM月dd日";
            break;
        case BPDateFormatterStyle_6:
            fmt = @"yyyy/MM/dd HH:mm";
            break;
        case BPDateFormatterStyle_7:
            fmt = @"HH:mm:ss";
            break;
        case BPDateFormatterStyle_8:
            fmt = @"mm:ss";
            break;
        case BPDateFormatterStyle_9:
            fmt = @"ss";
            break;
        case BPDateFormatterStyle_10:
            fmt = @"yyyy/MM/dd";
            break;
        case BPDateFormatterStyle_11:
            fmt = @"MM月dd日";
            break;
        case BPDateFormatterStyle_12:
            fmt = @"yyyyMMdd_HHmmss";
            break;
        case  BPDateFormatterStyle_13:
            fmt = @"HHmmss";
            break;
        case BPDateFormatterStyle_14:
            fmt = @"yyyy.MM.dd HH:mm:ss";
            break;
        case BPDateFormatterStyle_15:
            fmt = @"MM-dd";
            break;
        default:
            break;
    }
    NSDateFormatter *fmtter = [_fmtters objectForKey:fmt];
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
        fmtter.dateFormat = fmt;
        fmtter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_fmtters setObject:fmtter forKey:fmt];
    }
    return fmtter;
}

///将时间戳转换成指定时间格式的字符串(当时间戳为13位时需除以1000)
+ (NSString*)stringFromeTimeInterval:(NSString*)timeStamp with:(BPDateFormatterStyle)type{
    NSTimeInterval timeInterval = [timeStamp doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    NSDate* d = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    NSDateFormatter* formatter = [[YQhelper shareHelp] fmtterForStyle:type];
//    NSString* timeStr = [formatter stringFromDate:date];
    return [formatter stringFromDate:date];
}

///将指定时间格式的时间字符串转成date
+ (NSDate*)dateFromeTimeStr:(NSString*)timeStr with:(BPDateFormatterStyle)type{
    NSDateFormatter* formatter = [[YQhelper shareHelp] fmtterForStyle:type];
    NSDate *datestr = [formatter dateFromString:timeStr];
    return datestr;
}

///将指定囧hiJan格式的时间字符串转成时间戳
+ (NSString*)timeintervalStringFromeTimeString:(NSString*)timeStr with:(BPDateFormatterStyle)type{
    NSDateFormatter* formatter = [[YQhelper shareHelp] fmtterForStyle:type];
    NSDate *datestr = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datestr timeIntervalSince1970]];
    return timeSp;
}

///将指定囧hiJan格式的时间字符串转成NSTimeInterval
+ (NSTimeInterval)timeintervalFromeTimeString:(NSString*)timeStr with:(BPDateFormatterStyle)type{
    NSDateFormatter* formatter = [[YQhelper shareHelp] fmtterForStyle:type];
    NSDate *datestr = [formatter dateFromString:timeStr];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datestr timeIntervalSince1970]*1000];
    return [datestr timeIntervalSince1970];
}

/**
 判断对象是否为空，包括nil 空字符串、空字典、空数组等
 @param obj 对象
 @return 是否为空标识
 */
+(BOOL)isObjNil:(id _Nullable )obj{
    if (!obj) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)obj;
        if (dictionary.allKeys.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        if (array.count == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if (![obj length] || obj == nil || obj == NULL || [obj isKindOfClass:[NSNull class]] || [[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [obj isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    return NO;
}

+(UILabel*)createLabelWithFont:(UIFont*)font textAlignment:(NSTextAlignment)alignment textColor:(UIColor*)textColor backgroundColor:(UIColor*)bgcolor{
    UILabel* label = [UILabel new];
    label.backgroundColor = bgcolor ? bgcolor : [UIColor clearColor];
    label.textAlignment = alignment;
    label.font = font ? font : [UIFont systemFontOfSize:15];
    label.textColor = textColor ? textColor : [UIColor lightGrayColor];
    return label;
}
///创建线条
+(UILabel*)createlineLabelWithColor:(UIColor*)bgColor{
    UILabel* line = [UILabel new];
    line.backgroundColor = bgColor ? bgColor : [UIColor clearColor];
    return line;
}
///创建uitextfield
+(UITextField*)createUitextfieldWithFont:(UIFont*)font textColor:(UIColor* _Nullable)textColor; {
    UITextField* textF = [[UITextField alloc] init];
    textF.font = font;
    if (textColor) {
        textF.textColor = textColor;
    }
    return textF;
}

+(UIButton*)createButtonWithType:(UIButtonType)type andTitle:(NSString*)title andTitleColor:(UIColor*)titleColor andSelectedtitle:(NSString*)selectedTitle andSelectedColor:(UIColor*)selectedColor andFont:(UIFont*)font andBgColor:(UIColor*)bgColor{
    UIButton* button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (selectedTitle) {
        [button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    if (selectedColor) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = font;
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    return button;
}

+(UIButton*)createButtonWithTitle:(NSString*)title textAlignment:(NSTextAlignment)alignment font:(UIFont*)font titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)bgcolor{
    
    UIButton* button = [UIButton buttonWithType:0];
    button.titleLabel.textAlignment = alignment ? alignment : NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font ? font : [UIFont systemFontOfSize:15];
    [button setTitleColor:titleColor ? titleColor : [UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setBackgroundColor:bgcolor ? bgcolor : [UIColor clearColor]];
    return button;
}

+(UIButton*)createButtonWithType:(UIButtonType)type Image:(NSString*)imageName SelectedImage:(NSString*)selectedImageName{
    UIButton* button = [UIButton buttonWithType:type];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectedImageName.length) {
        [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    return button;
}

///创建UITextField
+(UITextField*)creatTextFieldWithPlaceHolder:(NSString*)placeHolder andTextColor:(UIColor*)textColor andFont:(UIFont*)font{
    UITextField* textF = [[UITextField alloc] init];
    textF.placeholder = placeHolder;
    textF.textColor = textColor;
    textF.font = font;
    return textF;
}

///创建imageView
+ (UIImageView *)createImageView:(CGRect)frame image:(UIImage *)image{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = image;
    imgView.backgroundColor = [UIColor clearColor];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    return imgView;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
    
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


///AlertActionSheet
+ (void)showActionSheetActions:(NSArray<UIAlertAction *> *)actions tips:(NSString *)tips message:(NSString *)message target:(UIViewController *)target {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tips message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
#pragma mark 解决弹出界面卡顿问题
    dispatch_async(dispatch_get_main_queue(), ^{
        [target presentViewController:alertController animated:YES completion:nil];
    });
}

///跳转到对应H5界面
+ (void)viewController:(UIViewController*)viewController showWebViewControllerWithUrlString:(NSString*)urlString{
//    YQbaseWebVC* webVC = [[YQbaseWebVC alloc] init];
//    webVC.isShowRightNavi = YES;
//    webVC.urlString = urlString;
//    webVC.hidesBottomBarWhenPushed = YES;
//    [viewController.navigationController pushViewController:webVC animated:YES];
}

///进入搜索界面
+ (void)viewControllerIntoSearchVC:(UIViewController*)viewController{
//    YQsearchBaseVC* search = [[YQsearchBaseVC alloc] init];
//    search.hidesBottomBarWhenPushed = YES;
//    [viewController.navigationController pushViewController:search animated:NO];
}

///全屏展示图片
+ (void)showImages:(NSArray*)images index:(NSInteger)index currentVC:(UIViewController*)currentVC{
    if(images.count < 1){
        return;
    }
    NSMutableArray *photos = [NSMutableArray new];
    if ([images.firstObject isKindOfClass:[UIImage class]]) {
        for(UIImage* image in images){
            GKPhoto *photo = [GKPhoto new];
            photo.image = image;
            [photos addObject:photo];
        }
    }else{
        for(NSString* url in images){
            GKPhoto *photo = [GKPhoto new];
            photo.url = [NSURL URLWithString:url];
            [photos addObject:photo];
        }
    }
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.hideStyle = GKPhotoBrowserShowStyleNone;
    //    browser.isFullScreenDisabled = YES;
    [browser showFromVC:currentVC];
}

///融云初始化/刷新指定用户数据
//+ (void)refreshRongCloud:(NSString*)uid and:(NSString*)name and:(NSString*)imageUrl{
//    RCUserInfo* userinfo = [[RCUserInfo alloc] initWithUserId:uid name:name portrait:imageUrl];
//    [[RCIM sharedRCIM] refreshUserInfoCache:userinfo withUserId:uid];
//}


//+ (void)toSchemeUrl:(NSURL *)url{
//    
//    NSDictionary *parameter = [NSString dictionaryWithUrlString:url.absoluteString];
//    UIViewController *vc = [self getCurrentVC];
//
//    if ([[url scheme] isEqualToString:yiqiScheme]) {    //本地服务
//        if (parameter[@"yqapp_action"]) {
//            
//            if ([parameter[@"yqapp_action"] isEqualToString:@"share"]) {
//                
//                YQshareDetailVC* shareDetail = [YQshareDetailVC new];
//                shareDetail.idString = [NSString stringWithFormat:@"%@",parameter[@"action_id"]];
//                shareDetail.hidesBottomBarWhenPushed = YES;
//                [vc.navigationController pushViewController:shareDetail animated:YES];
//            }else if ([parameter[@"yqapp_action"] isEqualToString:@"need"]){
//                YQneedDetailVC* needDetail = [YQneedDetailVC new];
//                needDetail.hidesBottomBarWhenPushed = YES;
//                needDetail.idStr = [NSString stringWithFormat:@"%@",parameter[@"action_id"]];
//                [vc.navigationController pushViewController:needDetail animated:YES];
//            }else if ([parameter[@"yqapp_action"] isEqualToString:@"release"]){
////                yiqibnb://test.yiqibnb.com?yqapp_action=release
//                YQcenterViewVC* center = [YQcenterViewVC new];
//                YQbaseNavigationC* navi = [[YQbaseNavigationC alloc] initWithRootViewController:center];
//                [vc.navigationController presentViewController:navi animated:true completion:^{
//                }];
//            }else if ([parameter[@"yqapp_action"] isEqualToString:@"address"]){
//                YQReceiptAddressListVC *addressVC = [[YQReceiptAddressListVC alloc] initWithReturnBlock:^(NSDictionary * _Nonnull model, YQReceiptAddressListVC * _Nonnull addressVC) {
//                    [addressVC dismissViewControllerAnimated:true completion:^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:appNoticeWebKey object:nil];
//                    }];
//                }];
//                YQbaseNavigationC* navi = [[YQbaseNavigationC alloc] initWithRootViewController:addressVC];
//                [vc.navigationController presentViewController:navi animated:true completion:nil];
//            }
//        }
//    }else if ([[url scheme] isEqualToString:httpsScheme]){  //https
//        [YQhelper viewController:vc showWebViewControllerWithUrlString:url.absoluteString];
//    }else if ([[url scheme] isEqualToString:httpScheme]){   //http
//        [YQhelper viewController:vc showWebViewControllerWithUrlString:url.absoluteString];
//    }
//    
//}

#pragma mark ------------- 正则表达式判断 ---------------
///身份证号YES：有效； NO：无效
+ (BOOL)isValidIdenditifyCard:(NSString*)cardStr{
    if ([YQhelper isObjNil:cardStr]) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:cardStr];
}
///邮箱YES：有效； NO：无效
+ (BOOL)isValidEmail:(NSString *)email{
    if ([YQhelper isObjNil:email]) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
///手机号码YES：有效； NO：无效
+ (BOOL)isValidPhoneeNumber:(NSString *)mobileNum{
    if ([YQhelper isObjNil:mobileNum]) {
        return NO;
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|6[0-9]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    }else{
        return NO;
    }
}
///金额格式YES：有效； NO：无效
+ (BOOL)isValidMoney:(NSString*)moneySr{
    //需求：
    ///位数可控（限定9位）
    ///小数点后两位
    ///开头最多输入一个0
    ///只能有一位小数点
    if ([YQhelper isObjNil:moneySr]) {
        return NO;
    }else{
        NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数
        NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        return [money evaluateWithObject:moneySr];
    }
}
///银行卡号YES：有效； NO：无效
+ (BOOL)isValidBankCard:(NSString *)cardNumber{
    if ([YQhelper isObjNil:cardNumber]) {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0, digit = 0, addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
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
//    NSLog(@"----------- platform = %@",platform);
///iphone
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
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    
///iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad (3rd generation)";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad (4th generation)";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro (9.7-inch)";
    
    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad (5th generation)";
    
    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad Pro (12.9-inch, 2nd generation)";
    
    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"]) return @"iPad Pro (10.5-inch)";
    
    if ([platform isEqualToString:@"iPad7,5"]) return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,6"]) return @"iPad (6th generation)";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    
    
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}








NSString* formatDate(NSInteger timespace){
    timespace = timespace /1000.0f;
    NSInteger current = [[NSDate date] timeIntervalSince1970];
    NSInteger gap = current - timespace;
    if(gap < 1){
        return @"刚刚";
    }else{
        if(gap < 60){
            return @"1分钟前";
        }else if(gap >= 60 && gap < 3600){
            return [NSString stringWithFormat:@"%ld分钟前",gap/60];
        }else if(gap >= 3600 && gap < 3600*24){
            return [NSString stringWithFormat:@"%ld小时前",gap/3600];
        }else if(gap >= 3600*24 && gap < 3600*24*2 ){
            return  @"昨天";
        }else if(gap >= 3600*24*2 && gap < 3600*24*3 ){
            return  @"前天";
        }else{
            return [YQhelper stringFromeTimeInterval:[NSString stringWithFormat:@"%ld",(long)timespace] with:(BPDateFormatterStyle_4)];
//            return [[NSDate dateWithTimeIntervalSince1970:timespace] toString:DATE_FORMATTER];
        }
    }
}
///金额格式
NSString* formatMoney(id money){
    double price = [money doubleValue];
    return [NSString stringWithFormat:@"%.2f",price];
}



//截取指定视图的指定区域，传入需要截取的view
+ (UIImage*)screenShotView:(UIView *)view{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 1);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef sourceImageRef = [imageRet CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, imageRet.size.height - statusBarHeight - 44, imageRet.size.width, statusBarHeight+44));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
//    return imageRet;
}

@end
