//
//  NSObject+YQHUD.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/27.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface NSObject (YQHUD)<MBProgressHUDDelegate>

-(void)presentMessageTips_:(NSString *)message;

- (void)presentMessageTips_:(NSString *)message dismisblock:(void(^)(void))dismissblock;

-(void)presentMessageTips:(NSString *)message;
- (void)presentMessageTips:(NSString *)message dismisblock:(void(^)(void))dismissblock;
- (void)presentMessageTips_:(NSString *)message duration:(CGFloat)duration dismisblock:(void(^)(void))dismissblock;
-(MBProgressHUD *)presentLoadingTips:(NSString *)message;
-(void)dismissTips;
-(void)presentFailureTips:(NSString *)message;
-(void)presentLoadinghud;
-(void)dismissAllTips;

@end
