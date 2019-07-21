//
//  SSvendorPaymentCell.m
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSvendorPaymentCell.h"
#import "TimerHelper.h"

@interface SSvendorPaymentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *banNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *backAllBtn;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@property (weak, nonatomic) IBOutlet UILabel *textL2;

@property (weak, nonatomic) IBOutlet UILabel *handingFeeL;
@property (weak, nonatomic) IBOutlet UIButton *shuomingBtn;

@property (weak, nonatomic) IBOutlet UIButton *yanJingBtn;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *getCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsendLabel;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UILabel *line1L;
@property (weak, nonatomic) IBOutlet UILabel *line2L;
@property (weak, nonatomic) IBOutlet UIView *bgv1;
@property (weak, nonatomic) IBOutlet UIView *bgv3;


@end

@implementation SSvendorPaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSubs];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubs {
    self.backgroundColor = [UIColor clearColor];
    [self.bgv1 setLayshadowwithRadiu:13 andShadowOffset:CGSizeMake(0, 0) andShadowCorlor:[UIColor YQshadowColor]];
    self.bgv1.layer.cornerRadius = 5;
    [self.bgv3 setLayshadowwithRadiu:13 andShadowOffset:CGSizeMake(0, 0) andShadowCorlor:[UIColor YQshadowColor]];
    self.bgv3.layer.cornerRadius = 5;
    
    ///分割线
    self.line1L.backgroundColor = self.line2L.backgroundColor = [UIColor YQcolorWithHexString:@"#EDEDED"];
    
    self.bankName.textColor = self.banNumLabel.textColor = self.handingFeeL.textColor = [UIColor YQcolorWithHex000000];
    self.textL.textColor = self.textL2.textColor = [UIColor YQcolorWithHex999999];
    self.label.textColor=self.getCodeLabel.textColor = [UIColor YQcolorWithHexString:@"#C62436"];
    
    self.getCodeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.getCodeLabel addGestureRecognizer:tap];
    
    [self.backAllBtn setTitleColor:[UIColor YQcolorWithHexString:@"#91856F"] forState:UIControlStateNormal];
    [self.backAllBtn setlayerOfViewRadius:self.backAllBtn.height/2 andLineWidth:1 andLineCorlor:[UIColor YQcolorWithHexString:@"#91856F"]];
    
    self.yanJingBtn.selected = NO;
    self.passwdTF.secureTextEntry = self.yanJingBtn.selected;
    [self.yanJingBtn setImage:[UIImage imageNamed:@"yanjin_open"] forState:UIControlStateNormal];
    [self.yanJingBtn setImage:[UIImage imageNamed:@"yanjin_close"] forState:UIControlStateSelected];
    
    [self.okBtn setBackgroundColor:[UIColor YQcolorWithHexString:@"#C2AB82"]];
    [self.okBtn setlayerOfViewRadius:5 andLineWidth:0 andLineCorlor:nil];
    
}
- (IBAction)clickBtns:(UIButton *)sender {
    if (sender.tag == 2) {
        sender.selected = !sender.selected;
        self.passwdTF.secureTextEntry = sender.selected;
    }
    if (self.vendorCellBlock) {
        self.vendorCellBlock(sender.tag);
    }
}

///获取验证码
- (void)tap:(UITapGestureRecognizer*)tap {
    [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:self.getCodeLabel];
    if (self.vendorCellBlock) {
        self.vendorCellBlock(3);
    }
}

@end
