//
//  SSorderDetailPriceCell.m
//  leeMail
//
//  Created by F S on 2019/7/18.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSorderDetailPriceCell.h"

@interface SSorderDetailPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

///商品金额
@property (weak, nonatomic) IBOutlet UILabel *amountL;
///优惠券抵扣金额
@property (weak, nonatomic) IBOutlet UILabel *couponL;
///运费
@property (weak, nonatomic) IBOutlet UILabel *freightL;
///应付金额
@property (weak, nonatomic) IBOutlet UILabel *payedAmountL;
///利润
@property (weak, nonatomic) IBOutlet UILabel *profitL;

@property (weak, nonatomic) IBOutlet UIButton *copybutton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *traillingConstraint;

@end

@implementation SSorderDetailPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSubV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubV {
    self.label1.font = self.label2.font = self.label3.font = self.label4.font = self.label5.font= [UIFont YQfont12];
    self.amountL.font = self.couponL.font = self.freightL.font = self.payedAmountL.font = self.profitL.font = [UIFont YQboldFont12];
    
    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = self.label5.textColor = [UIColor YQcolorWithHex333333];
    self.amountL.textColor = self.couponL.textColor = self.freightL.textColor = self.payedAmountL.textColor = self.profitL.textColor = [UIColor YQcolorWithHex000000];
}
- (IBAction)copyButton:(UIButton *)sender {
    
}

@end
