//
//  UIAlertController+EXtension.m
//  yiqi
//
//  Created by 戢俊龙 on 2018/9/7.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "UIAlertController+EXtension.h"

typedef void (^Submit) (void);
typedef void (^Cancel) (void);

@implementation UIAlertController (EXtension)

+ (instancetype)showWithTitle:(NSString*)title Message:(NSString*)message delegate:(UIViewController *)delegate Cancel:(void(^)(void))cancel Submit:(void(^)(void))submit{
    return [self showWithTitle:title Message:message cancelTitle:@"取消" otherTitle:@"确定" delegate:delegate Cancel:cancel Submit:submit];
}

+ (instancetype)showWithTitle:(NSString *)title Message:(NSString *)message cancelTitle:(NSString *)cancelTitle  otherTitle:(NSString *)otherTitle delegate:(UIViewController *)delegate Cancel:(void (^)(void))cancel Submit:(void (^)(void))submit{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController configurationIpadWithDelegate:delegate];

    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }];
    UIAlertAction *actionSubmit = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (submit) {
            submit();
        }
    }];
    [alertController addAction:actionCancel];
    [alertController addAction:actionSubmit];
    
    [delegate presentViewController:alertController animated:true completion:nil];
    return alertController;
    
}

+ (instancetype)showWithTitle:(NSString*)title Message:(NSString*)message delegate:(UIViewController *)delegate Submit:(void(^)(void))submit{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController configurationIpadWithDelegate:delegate];
    UIAlertAction *actionSubmit = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (submit) {
            submit();
        }
    }];
    [alertController addAction:actionSubmit];
    
    [delegate presentViewController:alertController animated:true completion:nil];

    return alertController;
}

//适配ipad
- (void)configurationIpadWithDelegate:(UIViewController *)delegate
{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
     if([deviceType isEqualToString:@"iPad"]) {
        //iPad
         UIPopoverPresentationController *popover =self.popoverPresentationController;
         
         popover.sourceView = delegate.view;
         
         popover.sourceRect = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);

         popover.permittedArrowDirections=UIPopoverArrowDirectionAny;
    }
}


@end
