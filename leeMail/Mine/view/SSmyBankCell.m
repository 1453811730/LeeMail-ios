//
//  SSmyBankCell.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyBankCell.h"

@interface SSmyBankCell ()
@property (weak, nonatomic) IBOutlet UILabel *bankNameL;
@property (weak, nonatomic) IBOutlet UILabel *bankNumL;
@property (weak, nonatomic) IBOutlet UIView *bgv;

@end

@implementation SSmyBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSub];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSub {
    self.backgroundColor = [UIColor clearColor];
    [self.bgv setLayshadowwithRadiu:5 andShadowOffset:CGSizeMake(0, 0) andShadowCorlor:RGBA(203, 136, 19, 0.18)];
    self.bgv.layer.cornerRadius = 6;
    self.bankNameL.textColor = [UIColor YQcolorWithHex000000];
    self.bankNumL.textColor = [UIColor YQmoneyColor];
}

@end
