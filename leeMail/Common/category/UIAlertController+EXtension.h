//
//  UIAlertController+EXtension.h
//  yiqi
//
//  Created by 戢俊龙 on 2018/9/7.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (EXtension)


/**
 显示alertVC
默认显示确定和取消按钮
 @param title 标题
 @param message 消息
 @param delegate 控制器
 @param cancel 返回按钮事件
 @param submit 确定按钮事件
 @return 返回实例
 */
+ (instancetype)showWithTitle:(NSString*)title Message:(NSString*)message delegate:(UIViewController *)delegate Cancel:(void(^)(void))cancel Submit:(void(^)(void))submit;


/**
 显示alertVC
 可以自定义俩个取消和返回按钮
 
 @param title 标题
 @param message 消息
 @param cancelTitle 返回按钮内容
 @param otherTitle 其他按钮内容
 @param delegate 控制器
 @param cancel 返回按钮事件
 @param submit 确定按钮事件
 @return 实例
 */
+ (instancetype)showWithTitle:(NSString *)title Message:(NSString *)message cancelTitle:(NSString *)cancelTitle  otherTitle:(NSString *)otherTitle delegate:(UIViewController *)delegate Cancel:(void (^)(void))cancel Submit:(void (^)(void))submit;


/**
 只有个确定按钮的alertVC

 @param title 标题
 @param message 信息
 @param delegate 控制器
 @param submit 确定按钮回调
 @return 实例
 */
+ (instancetype)showWithTitle:(NSString*)title Message:(NSString*)message delegate:(UIViewController *)delegate Submit:(void(^)(void))submit;


@end
