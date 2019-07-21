//
//  UINavigationController+Extension.m
//  yiqi
//
//  Created by 戢俊龙 on 2018/8/29.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (void)popViewControllerWithClass:(NSString *)className{
    
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            [self popToViewController:vc animated:true];
        }
    }
}

@end
