//
//  SSstatusView.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSstatusView.h"
#import <Masonry.h>

@implementation SSstatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
     [self setSubView];
}

- (void)setSubView {
//    self.backgroundColor = [UIColor redColor];
    for (int i=0; i<4; i++) {
        UIView* view = [[UIView alloc] init];
        view.tag = i;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i*self.frame.size.width/4);
            make.width.mas_equalTo(self.frame.size.width/4);
        }];
        
        if (i == 0) {
            self.firstBtnV = [[SSbadgeBtnV alloc] init];
            [view addSubview:self.firstBtnV];
            [self.firstBtnV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.bottom.mas_equalTo(view.mas_centerY);
            }];
            self.firstBtnV.imageV.image = [UIImage imageNamed:@"daifukuan"];
            [self.firstBtnV.imageV sizeToFit];
            
            UILabel* label = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentCenter textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.top.mas_equalTo(view.mas_centerY).mas_equalTo(8);
            }];
            label.text = @"待付款";
            [label sizeToFit];
            
        }else if (i == 1) {
            self.secondBtnV = [[SSbadgeBtnV alloc] init];
            [view addSubview:self.secondBtnV];
            [self.secondBtnV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.bottom.mas_equalTo(view.mas_centerY);
            }];
            self.secondBtnV.imageV.image = [UIImage imageNamed:@"fahuo"];
            [self.secondBtnV.imageV sizeToFit];
            
            UILabel* label = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentCenter textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.top.mas_equalTo(view.mas_centerY).mas_equalTo(8);
            }];
            label.text = @"待发货";
            [label sizeToFit];
            
        }else if (i == 2) {
            self.thirdBtnV = [[SSbadgeBtnV alloc] init];
            [view addSubview:self.thirdBtnV];
            [self.thirdBtnV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.bottom.mas_equalTo(view.mas_centerY);
            }];
            self.thirdBtnV.imageV.image = [UIImage imageNamed:@"shouhuo"];
            [self.thirdBtnV.imageV sizeToFit];
            
            UILabel* label = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentCenter textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.top.mas_equalTo(view.mas_centerY).mas_equalTo(8);
            }];
            label.text = @"待收货";
            [label sizeToFit];
            
        }else {
            self.forthBtnV = [[SSbadgeBtnV alloc] init];
            [view addSubview:self.forthBtnV];
            [self.forthBtnV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.bottom.mas_equalTo(view.mas_centerY);
            }];
            self.forthBtnV.imageV.image = [UIImage imageNamed:@"shouhuo"];
            [self.forthBtnV.imageV sizeToFit];
            
            UILabel* label = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentCenter textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.top.mas_equalTo(view.mas_centerY).mas_equalTo(8);
            }];
            label.text = @"全部订单";
            [label sizeToFit];
            
        }
        UIButton* btn = [UIButton buttonWithType:0];
        btn.tag = i;
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
        [btn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickBtns:(UIButton*)button {
    if (self.orderStatusBtnBlock) {
        self.orderStatusBtnBlock(button.tag);
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
