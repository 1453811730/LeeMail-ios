//
//  YQareaKeywindView.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/7/29.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "YQareaKeywindView.h"
#import "YQareaSelectedView.h"

@interface YQareaKeywindView ()
@end
@implementation YQareaKeywindView
- (YQareaSelectedView *)areaView{
    if (!_areaView) {
        _areaView = [[YQareaSelectedView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)-ScreenWidth*213/375, ScreenWidth, ScreenWidth*213/375)];
        _areaView.backgroundColor = [UIColor whiteColor];
        _areaView.containCurrentLocation = NO;
        _areaView.containAll = NO;
//        _areaView.filterConditions = _areasArray;
//            NSLog(@"------ %@",_areasArray);
    }
    return _areaView;
}

- (void)setAreasArray:(NSArray *)areasArray{
    _areasArray = areasArray;
//    NSLog(@"------ %@",_areasArray);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIWindow* wind = [UIApplication sharedApplication].keyWindow;
        [wind addSubview:self];
        self.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.3];
        weakly(self);
//        self.areaView.filterConditions = self.areasArray;
        self.areaView.areaSelectBlock = ^(NSDictionary *province, NSDictionary *city, NSDictionary *area) {
            if (weakSelf.areaSelectedCopyBlock) {
                weakSelf.areaSelectedCopyBlock(province, city, area);
            }
        };
        [self addSubview:self.areaView];
    }
    return self;
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
