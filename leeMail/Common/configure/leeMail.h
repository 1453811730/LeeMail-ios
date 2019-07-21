//
//  leeMail.h
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#ifndef leeMail_h
#define leeMail_h

#define keyWindowWidth ([UIApplication sharedApplication].keyWindow.bounds.size.width)
#define keyWindowHeight ([UIApplication sharedApplication].keyWindow.bounds.size.height)
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define NaviBarHeight 44.f
#define NAVIHEIGHT   ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)
#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define TabBarHeight (isIphoneX ? 83.f : 49.f)
#define tabBarBottomH (isIphoneX ? 34.f : 0.f)
#define APPDELEGATE (AppDelegate*)[UIApplication sharedApplication].delegate
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define weakly(self) __weak typeof(self)weakSelf = self
#define strongly(weakSelf) __strong typeof(weakSelf)strongSelf = weakSelf


#pragma --------------设备型号-----------------
#define IS_IPAD                 [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE               [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define isIphoneX               (keyWindowWidth == 375.f && keyWindowHeight == 812.f)

#pragma --------------系统版本-----------------
#define IS_IOS_VERSION  [[UIDevice currentDevice].systemVersion floatValue]
#define IS_IOS_5        floorf([[UIDevice currentDevice].systemVersion floatValue]) == 5.0  ? 1 : 0
#define IS_IOS_6        floorf([[UIDevice currentDevice].systemVersion floatValue]) == 6.0  ? 1 : 0
#define IS_IOS_7        floorf([[UIDevice currentDevice].systemVersion floatValue]) == 7.0  ? 1 : 0
#define IS_IOS_8        floorf([[UIDevice currentDevice].systemVersion floatValue]) == 8.0  ? 1 : 0
#define IS_IOS_9        floorf([[UIDevice currentDevice].systemVersion floatValue]) == 9.0  ? 1 : 0
#define IS_IOS_10       floorf([[UIDevice currentDevice].systemVersion floatValue]) == 10.0 ? 1 : 0
#define IS_IOS_11       floorf([[UIDevice currentDevice].systemVersion floatValue]) == 11.0 ? 1 : 0



#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif


#endif /* leeMail_h */
