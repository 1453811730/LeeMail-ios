//
//  SSorderDetailHeadV.m
//  leeMail
//
//  Created by F S on 2019/7/18.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSorderDetailHeadV.h"
#import <Masonry.h>

@interface SSorderDetailHeadV ()
@property(nonatomic,strong) UIImageView* bgImagV;
@property(nonatomic,strong) UILabel* statusLabel;
@property(nonatomic,strong) UILabel* timeLabel;

///收件人信息背景图
@property(nonatomic,strong) UIView* bgView;
///收件人
@property(nonatomic,strong) UILabel* recipientLabel;
@property(nonatomic,strong) UILabel* phoneLabel;
@property(nonatomic,strong) UIImageView* addrImageV;
@property(nonatomic,strong) UILabel* addrLabel;

@end

@implementation SSorderDetailHeadV


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubV];
    }
    return self;
}

- (void)setSubV {
    self.bgImagV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orderDetailBG"]];
    self.bgImagV.contentMode = UIViewContentModeScaleToFill;
    self.bgImagV.clipsToBounds = YES;
    [self addSubview:self.bgImagV];
    [self.bgImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(82);
    }];
    
    self.statusLabel = [YQhelper createLabelWithFont:[UIFont YQboldFont18] textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] backgroundColor:nil];
    [self addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(17);
    }];
    
    self.timeLabel = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentRight textColor:[UIColor whiteColor] backgroundColor:nil];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.statusLabel.mas_centerY);
        make.right.mas_equalTo(-12);
    }];
    
    ///以下收件人相关信息
    self.bgView = [[UIView alloc] init];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(57);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(70);
    }];
    [self.bgView setLayshadowwithRadiu:15 andShadowOffset:CGSizeMake(0, 0) andShadowCorlor:[UIColor YQshadowColor]];
    self.bgView.layer.cornerRadius = 5;
    
    ///收件人
    self.recipientLabel = [YQhelper createLabelWithFont:[UIFont YQboldFont15] textAlignment:NSTextAlignmentLeft textColor:[UIColor YQcolorWithHex000000] backgroundColor:nil];
    [self.bgView addSubview:self.recipientLabel];
    [self.recipientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
    }];
    
    self.phoneLabel = [YQhelper createLabelWithFont:[UIFont YQboldFont15] textAlignment:NSTextAlignmentLeft textColor:[UIColor YQcolorWithHex000000] backgroundColor:nil];
    [self.bgView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.recipientLabel.mas_right).mas_equalTo(30);
        make.centerY.mas_equalTo(self.recipientLabel.mas_centerY);
    }];
    
    self.addrImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
    [self.bgView addSubview:self.addrImageV];
    [self.addrImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.recipientLabel.mas_left);
        make.top.mas_equalTo(self.recipientLabel.mas_bottom).mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    self.addrLabel = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentLeft textColor:[UIColor YQcolorWithHex000000] backgroundColor:nil];
    [self.bgView addSubview:self.addrLabel];
    [self.addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addrImageV.mas_right).mas_equalTo(4);
        make.centerY.mas_equalTo(self.addrImageV.mas_centerY);
        make.right.mas_equalTo(0);
    }];
    ///用于点击选择地址
    UIButton* btn = [UIButton buttonWithType:0];
    [self.bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    [btn addTarget:self action:@selector(selecteAddr) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)selecteAddr {
    if (self.selecteAddrBlock) {
        self.selecteAddrBlock();
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
