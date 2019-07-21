//
//  SScenterHeadV.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SScenterHeadV.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "UIButton+YQcategory.h"

@interface SScenterHeadV ()
@property(nonatomic,strong) UILabel* descriptLabel;
@property(nonatomic,strong) UIImageView* bgImagV;
@property(nonatomic,strong) UIButton* lookBtn;
@end

@implementation SScenterHeadV

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSuvView];
    }
    return self;
}

- (void)setSuvView {
    self.clipsToBounds = YES;
    self.headImagV = [[UIImageView alloc] init];
//    self.headImagV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.headImagV];
    [self.headImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(6);
//        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(75);
    }];
   
    
    self.usernameLabel = [YQhelper createLabelWithFont:[UIFont YQfont20] textAlignment:NSTextAlignmentCenter textColor:[UIColor YQcolorWithHex000000] backgroundColor:nil];
    [self addSubview:self.usernameLabel];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.headImagV.mas_bottom).mas_equalTo(18);
    }];
    
    self.descriptLabel = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentCenter textColor:[UIColor YQcolorWithHexString:@"#CCCCCC" andAlpha:1] backgroundColor:nil];
    self.descriptLabel.text = @"查看并编辑个人资料";
    [self addSubview:self.descriptLabel];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_equalTo(12);
    }];
    
    UIButton* button = [UIButton buttonWithType:0];
    button.tag = 0;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.descriptLabel.mas_bottom);
    }];
    [button addTarget:self action:@selector(lookDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgImagV = [[UIImageView alloc] init];
    self.bgImagV.contentMode = UIViewContentModeScaleToFill;
    self.bgImagV.userInteractionEnabled = YES;
    self.bgImagV.clipsToBounds = YES;
    [self addSubview:self.bgImagV];
    [self.bgImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.descriptLabel.mas_bottom).mas_equalTo(14);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(77);
    }];
    self.bgImagV.image = [UIImage imageNamed:@"beijing"];
    
    UIButton* lookDetailBtn = [YQhelper createButtonWithType:0 andTitle:@"查询明细  >" andTitleColor:[UIColor whiteColor] andSelectedtitle:@"查询明细  >" andSelectedColor:[UIColor whiteColor] andFont:[UIFont YQfont12] andBgColor:nil];
    lookDetailBtn.tag = 1;
    [self.bgImagV addSubview:lookDetailBtn];
    [lookDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-11);
        make.width.mas_equalTo(65);
    }];
    [lookDetailBtn addTarget:self action:@selector(lookDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.totalMoneyTF = [[UITextField alloc] init];
    self.totalMoneyTF.userInteractionEnabled = NO;
    self.totalMoneyTF.font = [UIFont YQfont16];
    self.totalMoneyTF.textColor = [UIColor whiteColor];
    [self.bgImagV addSubview:self.totalMoneyTF];
    [self.totalMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(self.bgImagV.mas_centerY).mas_equalTo(1);
        make.height.mas_equalTo(26);
        make.right.mas_equalTo(lookDetailBtn.mas_left).mas_equalTo(0);
    }];
    
    UILabel* label = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] backgroundColor:nil];
    label.text = @"总资产";
    [self.bgImagV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(self.bgImagV.mas_bottom).mas_equalTo(-18);
    }];
    
    self.lookBtn = [YQhelper createButtonWithType:0 Image:@"yanjing" SelectedImage:@"yanjing"];
    self.lookBtn.selected = NO;
    self.totalMoneyTF.secureTextEntry = self.lookBtn.selected;
    [self.bgImagV addSubview:self.lookBtn];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).mas_equalTo(6);
        make.centerY.mas_equalTo(label.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 8));
    }];
    [self.lookBtn YQsetEnlargeEdge:16];
    [self.lookBtn addTarget:self action:@selector(looBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)looBtn:(UIButton*)button {
    button.selected = !button.selected;
    self.totalMoneyTF.secureTextEntry = button.selected;
    NSString* str = self.totalMoneyTF.text;
    if (self.totalMoneyTF.secureTextEntry) {
        self.totalMoneyTF.text = str;
    }else {
        self.totalMoneyTF.attributedText = [str ss_strAttriWithRange:NSMakeRange(0, 1) andFont:16 withColor:[UIColor whiteColor] andRange:NSMakeRange(1, str.length-1) and:24 with:[UIColor whiteColor]];
    }
}

- (void)lookDetailBtn:(UIButton*)button {
    if (self.block) {
        self.block(button.tag);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setUserModel:(SSusermodel *)userModel {
    _userModel = userModel;
    NSLog(@"---url = %@       name = %@",userModel.headImg,userModel.name);
    [self.headImagV sd_setImageWithURL:[NSURL URLWithString:userModel.headImg] placeholderImage:nil];
    [self.headImagV setlayerOfViewRadius:37.5 andLineWidth:0 andLineCorlor:nil];
    NSString* str = @"¥190,099.00";
    self.totalMoneyTF.attributedText = [str ss_strAttriWithRange:NSMakeRange(0, 1) andFont:16 withColor:[UIColor whiteColor] andRange:NSMakeRange(1, str.length-1) and:24 with:[UIColor whiteColor]];
    self.usernameLabel.text = userModel.phone;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
