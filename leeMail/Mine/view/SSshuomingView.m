//
//  SSshuomingView.m
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSshuomingView.h"
#import <Masonry.h>
#import "SSshuoMingV.h"
#import "SSshuoMForVendorV.h"

@interface SSshuomingView ()
@property(nonatomic,strong) UIView* whiteView;

@end

@implementation SSshuomingView
- (SSshuoMingV *)shuoV {
    if (!_shuoV) {
        _shuoV = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSshuoMingV class]) owner:self options:nil] firstObject];
        _shuoV.frame = CGRectMake(0, 0, 300, 500);
        _shuoV.closeBtn.userInteractionEnabled = NO;
    }
    return _shuoV;
}
- (SSshuoMForVendorV *)shuoForVendorV {
    if (!_shuoForVendorV) {
        _shuoForVendorV = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSshuoMForVendorV class]) owner:self options:nil] firstObject];
        _shuoForVendorV.frame = CGRectMake(0, 0, 300, 156);
        _shuoForVendorV.closeBtn.userInteractionEnabled = NO;
    }
    return _shuoForVendorV;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor  = RGBA(0, 0, 0, 0.6);
        UIWindow* keywind = [UIApplication sharedApplication].keyWindow;
        [keywind addSubview:self];
        self.centerx = keywind.centerx;
        self.centery = keywind.centery;
        
        self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, 300, 500)];
        self.whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteView];
        self.whiteView.centerx = self.centerx;
        
//        SSshuoMingV* shuoV = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSshuoMingV class]) owner:self options:nil] firstObject];
//        shuoV.frame = CGRectMake(0, 0, 300, 500);
//        [self.whiteView addSubview:shuoV];
        
        
        
    }
    return self;
}

- (void)showInWallet {
    [self.whiteView addSubview:self.shuoV];
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteView.centery = self.centery;
    }];
}

- (void)showInVendorPayment {
    self.whiteView.height = 156;
    [self.whiteView addSubview:self.shuoForVendorV];
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteView.centery = self.centery;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteView.y = ScreenHeight;
    } completion:^(BOOL finished) {
        
        [self.whiteView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
