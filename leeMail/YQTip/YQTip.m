//
//  YQTip.m
//  yiqi
//
//  Created by 戢俊龙 on 2018/8/30.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "YQTip.h"

#define YQTIP_DEFAULR_BGCOLOR       [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]
#define YQTIP_DEFAULR_TIPCOLOR      [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]
#define YQTIP_DEFAULT_FONT          [UIFont systemFontOfSize:12]
#define YQTIP_DEFAULT_DELAY         1.5
#define YQMAINSIZE                  [[UIScreen mainScreen] bounds].size


@interface YQTip ()
{
    UILabel*        _label;
}
@end

@implementation YQTip


- (void)show
{
    
    //if (_parent && _tip && ![_tip isKindOfClass:[NSNull class]]) {
    if (_tip && ![_tip isKindOfClass:[NSNull class]]) {
        self.backgroundColor = _backGroundColor ? _backGroundColor :YQTIP_DEFAULR_BGCOLOR;
        CGFloat alpha = self.alpha;
        self.alpha = 0;
        self.layer.cornerRadius = 5.0f;
        self.tag = 5001;
        
        for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
            if (subView.tag == 5001) {
                [subView removeFromSuperview];
            }
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.mj_w - 10, self.mj_h - 10)];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = _tip;
        _label.numberOfLines = 2;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = _font ? _font : YQTIP_DEFAULT_FONT;
        CGSize max = CGSizeMake(300, 300);
        CGSize size = [_tip boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:_label.font} context:nil].size;
        
        CGFloat height = size.height +10;
        CGFloat width = MAX(size.width, 60);
        _label.mj_h = height;
        _label.textColor = _tipColor ? _tipColor : YQTIP_DEFAULR_TIPCOLOR;
        [self addSubview:_label];
        self.mj_h = height + 10;
        self.mj_w = width + 40;
        if (self.mj_x == 0 && self.mj_y == 0) {
            CGPoint point = [UIApplication sharedApplication].keyWindow.center;
//            point.y = YQMAINSIZE.height - self.height - 130;
            point.y = _y != 0 ? _y : ScreenHeight/2 + 50;
            self.center = point;
        }
        
        _label.frame = CGRectMake(10, 5, self.width - 20, self.height - 10);
        
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = alpha;
        } completion:^(BOOL finished) {
            if (finished) {
                [self performBlock:^{
                    [UIView animateWithDuration:0.5 animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        //                        if (finished) {
                        [self removeFromSuperview];
                        //                        }
                    }];
                } AfterDelay:(_delay ? _delay : YQTIP_DEFAULT_DELAY)];
            }else{
                NSLog(@"finished = NO");
                [self removeFromSuperview];
                
            }
        }];
    }
}

- (void)performBlock:(void(^)(void))block AfterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlock:) withObject:block afterDelay:delay];
}

- (void)fireBlock:(void (^)(void))block
{
    block();
}
@end
