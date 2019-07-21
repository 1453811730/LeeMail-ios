//
//  SSmyWalletHeadV.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyWalletHeadV.h"
#import <Masonry.h>
#import "UIButton+YQcategory.h"

@interface SSmyWalletHeadV ()
@property(nonatomic,strong) UITextField* totalMoneyTF;
@property(nonatomic,strong) UITextField* leiJiTF;
@property(nonatomic,strong) UITextField* huiKuanTF;
@property(nonatomic,strong) UITextField* yongJinTF;

@property(nonatomic,strong) UITextField* canUseLabel;
@property(nonatomic,strong) UITextField* lirunLabel;
@property(nonatomic,strong) UITextField* daiShouLabel;

@end

@implementation SSmyWalletHeadV

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubV];
    }
    return self;
}

- (void)setSubV {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    UIImageView* bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 135)];
    bgImageV.image = [UIImage imageNamed:@"walletBG"];
    bgImageV.userInteractionEnabled = YES;
    [self addSubview:bgImageV];
//    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.left.mas_equalTo(0);
//        make.height.mas_equalTo(135);
//    }];
    
    UILabel* label = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] backgroundColor:nil];
    [bgImageV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(24);
    }];
    label.text = @"总资产";
    [label sizeToFit];
    
    UIButton* lookBtn = [YQhelper createButtonWithType:0 Image:@"yanjin_open" SelectedImage:@"yanjin_close"];
    lookBtn.selected = NO;
    lookBtn.tag = 0;
    [bgImageV addSubview:lookBtn];
    [lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label.mas_centerY);
        make.left.mas_equalTo(label.mas_right).mas_equalTo(5);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(12);
    }];
    [lookBtn YQsetEnlargeEdge:15];
    [lookBtn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* shuoMingLabel = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] backgroundColor:nil];
    [bgImageV addSubview:shuoMingLabel];
    [shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(label.mas_centerY);
    }];
    shuoMingLabel.text = @"说明";
    [shuoMingLabel sizeToFit];
    
    UIButton* btn = [YQhelper createButtonWithType:0 Image:@"tishishuoming" SelectedImage:@""];
    btn.tag = 1;
    [bgImageV addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label.mas_centerY);
        make.right.mas_equalTo(shuoMingLabel.mas_left).mas_equalTo(-5);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(12);
    }];
    [btn YQsetEnlargeEdge:15];
    [btn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    self.totalMoneyTF = [[UITextField alloc] init];
    self.totalMoneyTF.textColor = [UIColor whiteColor];
    self.totalMoneyTF.font = [UIFont YQfont16];
    self.totalMoneyTF.userInteractionEnabled = NO;
//    self.totalMoneyTF.backgroundColor = [UIColor greenColor];
    self.totalMoneyTF.secureTextEntry = lookBtn.selected;
    [bgImageV addSubview:self.totalMoneyTF];
    [self.totalMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.right.mas_equalTo(bgImageV.mas_centerX);
        make.height.mas_equalTo(24);
//        make.top.mas_equalTo(label.mas_bottom).mas_equalTo(18);
        make.centerY.mas_equalTo(bgImageV.mas_centerY).mas_equalTo(-3.5);
    }];
    
    ///回款中
    UIView* huiKbgV = [[UIView alloc] init];
    huiKbgV.backgroundColor = [UIColor YQcolorWithHexString:@"#BFAC8C"];
    [bgImageV addSubview:huiKbgV];
    [huiKbgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totalMoneyTF.mas_centerY);
        make.right.mas_equalTo(bgImageV.mas_right).mas_equalTo(10.5);
        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(125);
    }];
    [huiKbgV setlayerOfViewRadius:10.5 andLineWidth:0 andLineCorlor:nil];
    
    self.huiKuanTF = [[UITextField alloc] init];
    self.huiKuanTF.textColor = [UIColor whiteColor];
    self.huiKuanTF.font = [UIFont YQfont11];
    self.huiKuanTF.userInteractionEnabled = NO;
    self.huiKuanTF.secureTextEntry = lookBtn.selected;
    [huiKbgV addSubview:self.huiKuanTF];
    [self.huiKuanTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(huiKbgV.mas_left).mas_equalTo(10);
        make.centerY.mas_equalTo(huiKbgV.mas_centerY);
        make.width.mas_equalTo(huiKbgV.mas_width).mas_equalTo(-25);
    }];
//    self.huiKuanTF.text = @"¥1234225.67";
    
//    UILabel* huiLabel = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentRight textColor:[UIColor whiteColor] backgroundColor:nil];
//    huiLabel.text = @"回款中";
//    [huiKbgV addSubview:huiLabel];
//    [huiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.huiKuanTF.mas_right);
//        make.centerY.mas_equalTo(huiKbgV.mas_centerY);
//    }];
    
    ///累计收益
    UILabel* leiJILabel = [YQhelper createLabelWithFont:[UIFont YQfont12] textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] backgroundColor:nil];
    [bgImageV addSubview:leiJILabel];
    [leiJILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.top.mas_equalTo(self.totalMoneyTF.mas_bottom).mas_equalTo(16);
    }];
    leiJILabel.text = @"累计收益";
    [leiJILabel sizeToFit];
    
    self.leiJiTF = [[UITextField alloc] init];
    self.leiJiTF.textColor = [UIColor whiteColor];
    self.leiJiTF.font = [UIFont YQfont12];
    self.leiJiTF.userInteractionEnabled = NO;
    self.leiJiTF.secureTextEntry = lookBtn.selected;
    [bgImageV addSubview:self.leiJiTF];
    [self.leiJiTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leiJILabel.mas_right);
        make.centerY.mas_equalTo(leiJILabel.mas_centerY);
    }];
    
    ///佣金待入账
    UIView* yongV = [[UIView alloc] init];
    yongV.backgroundColor = [UIColor YQcolorWithHexString:@"#BFAC8C"];
    [bgImageV addSubview:yongV];
    [yongV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(huiKbgV.mas_bottom).mas_equalTo(14);
        make.right.mas_equalTo(bgImageV.mas_right).mas_equalTo(10.5);
        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(118);
    }];
    [yongV setlayerOfViewRadius:10.5 andLineWidth:0 andLineCorlor:nil];
    
    self.yongJinTF = [[UITextField alloc] init];
    self.yongJinTF.textColor = [UIColor whiteColor];
    self.yongJinTF.font = [UIFont YQfont11];
    self.yongJinTF.userInteractionEnabled = NO;
    self.yongJinTF.secureTextEntry = lookBtn.selected;
    [yongV addSubview:self.yongJinTF];
    [self.yongJinTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yongV.mas_left).mas_equalTo(10);
        make.centerY.mas_equalTo(yongV.mas_centerY);
        make.width.mas_equalTo(yongV.mas_width).mas_equalTo(-25);
    }];
    self.yongJinTF.text = @"¥50.00佣金待入账";
    
    ///
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(bgImageV.frame)-16, ScreenWidth-15*2, 125)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    for (int i=0; i<3; i++) {
        UIView* view = [[UIView alloc] init];
        view.tag = i;
        [bgView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView.mas_centerY);
            make.top.mas_equalTo(bgView.mas_top).mas_equalTo(0);
            make.left.mas_equalTo(bgView.mas_left).mas_equalTo(i*bgView.frame.size.width/3);
            make.width.mas_equalTo(bgView.frame.size.width/3);
        }];
        
        if (i == 0) {
            UILabel* label0 = [YQhelper createLabelWithFont:[UIFont YQfont11] textAlignment:NSTextAlignmentLeft textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label0];
            [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.top.mas_equalTo(12);
            }];
            label0.text = @"可用资产";
            [label0 sizeToFit];
            
            self.canUseLabel = [YQhelper createUitextfieldWithFont:[UIFont YQboldFont12] textColor:[UIColor YQcolorWithHex010101]];
            self.canUseLabel.secureTextEntry = lookBtn.selected;
            [view addSubview:self.canUseLabel];
            [self.canUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.top.mas_equalTo(label0.mas_bottom).mas_equalTo(6);
                make.right.mas_equalTo(0);
            }];
            self.canUseLabel.text = @"¥190,099.00";
            [self.canUseLabel sizeToFit];
            
            ///厂商回款
            UIButton* btn = [YQhelper createButtonWithType:0 andTitle:@"厂商回款>" andTitleColor:[UIColor YQcolorWithHexString:@"#91856F"] andSelectedtitle:nil andSelectedColor:nil andFont:[UIFont YQfont11] andBgColor:nil];
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            btn.tag = 3;
            [view addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.top.mas_equalTo(label0.mas_bottom).mas_equalTo(26);
                make.size.mas_equalTo(CGSizeMake(60, 11));
            }];
            [btn YQsetEnlargeEdge:10];
            [btn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1) {
            UILabel* label0 = [YQhelper createLabelWithFont:[UIFont YQfont11] textAlignment:NSTextAlignmentLeft textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label0];
            [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.top.mas_equalTo(12);
            }];
            label0.text = @"利润";
            [label0 sizeToFit];
            
            self.lirunLabel = [YQhelper createUitextfieldWithFont:[UIFont YQboldFont12] textColor:[UIColor YQcolorWithHex010101]];
            self.lirunLabel.secureTextEntry = lookBtn.selected;
            [view addSubview:self.lirunLabel];
            [self.lirunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(label0.mas_bottom).mas_equalTo(6);
            }];
            self.lirunLabel.text = @"¥190,099.00";
            [self.lirunLabel sizeToFit];
        }else {
            UILabel* label0 = [YQhelper createLabelWithFont:[UIFont YQfont11] textAlignment:NSTextAlignmentLeft textColor:[UIColor YQcolorWithHex010101] backgroundColor:nil];
            [view addSubview:label0];
            [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.top.mas_equalTo(12);
            }];
            label0.text = @"代售金额";
            [label0 sizeToFit];
            
            self.daiShouLabel = [YQhelper createUitextfieldWithFont:[UIFont YQboldFont12] textColor:[UIColor YQcolorWithHex010101]];
            self.daiShouLabel.secureTextEntry = lookBtn.selected;
            [view addSubview:self.daiShouLabel];
            [self.daiShouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(label0.mas_bottom).mas_equalTo(6);
            }];
            self.daiShouLabel.text = @"¥190,099.00";
            [self.daiShouLabel sizeToFit];
        }
        
    }
    
    ///继续购物按钮
    UIButton* jiXuBtn = [YQhelper createButtonWithType:0 andTitle:@"继续购物" andTitleColor:[UIColor whiteColor] andSelectedtitle:nil andSelectedColor:nil andFont:[UIFont YQfont12] andBgColor:[UIColor YQcolorWithHexString:@"#C2AB82"]];
    jiXuBtn.tag = 2;
    [bgView addSubview:jiXuBtn];
    [jiXuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_equalTo(-18);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [jiXuBtn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
//    NSString* str1 = [NSString stringWithFormat:@"%.2f",[dic[@"availableFund"] floatValue]];
//    NSString* str2 = [NSString stringWithFormat:@"%.2f",[dic[@"saleProfit"] floatValue]];
//    NSString* str3 = [NSString stringWithFormat:@"%.2f",[dic[@"saleAmount"] floatValue]];
//    NSString* str4 = [NSString stringWithFormat:@"%.2f",[dic[@"frozenSum"] floatValue]];
    
    CGFloat sum = [dic[@"availableFund"] floatValue] + [dic[@"saleProfit"] floatValue] + [dic[@"saleAmount"] floatValue] + [dic[@"frozenSum"] floatValue];
    NSString* str = [NSString stringWithFormat:@"¥%.2f",sum];
    if (self.totalMoneyTF.secureTextEntry) {
        self.totalMoneyTF.text = str;
    }else {
        self.totalMoneyTF.attributedText = [str ss_strAttriWithRange:NSMakeRange(0, 1) andFont:16 withColor:[UIColor whiteColor] andRange:NSMakeRange(1, str.length-1) and:24 with:[UIColor whiteColor]];
    }
    
//    self.totalMoneyTF.text = [NSString stringWithFormat:@"%@",dic[@"cardTotalNum"]];
    self.leiJiTF.text = [NSString stringWithFormat:@"¥%@",dic[@"profitSum"]];
    self.huiKuanTF.text = [NSString stringWithFormat:@"¥%@回款中",dic[@"frozenSum"]];
    self.yongJinTF.text = [NSString stringWithFormat:@"¥%@佣金待入账",dic[@"pendingCommission"]];

    self.canUseLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"availableFund"] floatValue]];
    self.lirunLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"saleProfit"] floatValue]];
    self.daiShouLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"saleAmount"] floatValue]];
    
    str = nil;
}

///0：眼睛按钮；1：说明按钮；2：继续购物；3：厂商回款
- (void)clickBtns:(UIButton*)button {
    if (button.tag == 0) {
        button.selected = !button.selected;
        self.totalMoneyTF.secureTextEntry = button.selected;
        self.leiJiTF.secureTextEntry = button.selected;
        self.huiKuanTF.secureTextEntry = button.selected;
        self.yongJinTF.secureTextEntry = button.selected;
        
        self.canUseLabel.secureTextEntry = button.selected;
        self.lirunLabel.secureTextEntry = button.selected;
        self.daiShouLabel.secureTextEntry = button.selected;
        
        NSString* str = self.totalMoneyTF.text;
        if (self.totalMoneyTF.secureTextEntry) {
            self.totalMoneyTF.text = str;
        }else {
            self.totalMoneyTF.attributedText =  [str ss_strAttriWithRange:NSMakeRange(0, 1) andFont:16 withColor:[UIColor whiteColor] andRange:NSMakeRange(1, str.length-1) and:24 with:[UIColor whiteColor]];
//            self.totalMoneyTF.text = str;
        }
        str = nil;
    }
    if (self.walletHeadBLock) {
        self.walletHeadBLock(button.tag);
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
