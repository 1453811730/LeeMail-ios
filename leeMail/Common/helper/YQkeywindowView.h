//
//  YQkeywindowView.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/8/16.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQkeywindowView : UIView

@property (strong,nonatomic,readonly) UIView* backgroundView;
@property (weak,nonatomic) UIView* contentView;
@property (assign,nonatomic) BOOL anim;
@property (assign,nonatomic) BOOL isShow;
@property (assign,nonatomic) UIViewContentMode contentMode;
-(instancetype) customViewWithAlpha:(CGFloat) alp;
-(instancetype) customerView;
-(void) show;
-(void) dismiss;

+(YQkeywindowView*) showView:(UIView*)contentView contentMode:(UIViewContentMode)contentMode;
+(BOOL) isShowCustomView;
+(void) dismissCustomView;

@end
