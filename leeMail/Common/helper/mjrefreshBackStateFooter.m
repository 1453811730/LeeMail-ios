//
//  mjrefreshBackStateFooter.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/8/8.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "mjrefreshBackStateFooter.h"

@implementation mjrefreshBackStateFooter

#pragma mark - 懒加载子控件
- (UIImage *)image
{
    return _image ? _image : [UIImage imageNamed:@"icon_loading_1"];
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:self.image];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

- (UIImageView *)loadImageView
{
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc] initWithImage:self.image];
//        NSMutableArray *arr = [NSMutableArray array];
//        for (int i = 1; i <= 30; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_loading_%d", i]];
//            [arr addObject:image];
//        }
//        _loadImageView.animationImages = arr;
        _loadImageView.animationDuration = 0.4;
        _loadImageView.animationRepeatCount = 0;
        [self addSubview:_loadImageView];
    }
    return _loadImageView;
}



#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.stateLabel.textColor = [UIColor lightGrayColor];
    [self setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    [self setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"————————  我是有底线的  ————————" forState:MJRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= self.labelLeftInset + self.stateLabel.mj_textWith * 0.5;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    self.arrowImageView.mj_size = CGSizeMake(24, 24);
    self.arrowImageView.center = arrowCenter;
    self.loadImageView.mj_size = CGSizeMake(24, 24);
    self.loadImageView.center = arrowCenter;
}

- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            //            self.arrowImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            //            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            //                self.loadImageView.alpha = 0.0;
            //            } completion:^(BOOL finished) {
            self.loadImageView.alpha = 1.0;
            [self.loadImageView stopAnimating];
            self.loadImageView.hidden = YES;
            self.arrowImageView.hidden = NO;
            //            }];
        } else {
            [self.loadImageView stopAnimating];
            self.loadImageView.hidden = NO;
            self.arrowImageView.hidden = NO;
            //            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            //                self.arrowImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            //            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadImageView stopAnimating];
        self.loadImageView.hidden = YES;
        self.arrowImageView.hidden = NO;
        //        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
        //            self.arrowImageView.transform = CGAffineTransformIdentity;
        //        }];
    } else if (state == MJRefreshStateRefreshing) {
        [self.loadImageView startAnimating];
        self.loadImageView.hidden = NO;
        self.arrowImageView.hidden = YES;
    } else if (state == MJRefreshStateNoMoreData) {
        [self.loadImageView stopAnimating];
        self.loadImageView.hidden = YES;
        self.arrowImageView.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
