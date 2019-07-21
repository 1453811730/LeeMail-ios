
//
//  SSaddBankCell.m
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSaddBankCell.h"

@interface SSaddBankCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;



@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation SSaddBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSuv];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSuv {
    self.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = [UIColor clearColor];
    self.line1.backgroundColor = self.line2.backgroundColor = self.line4.backgroundColor = [UIColor YQseparatorColor];
    self.line3.backgroundColor = self.line5.backgroundColor = [UIColor clearColor];
    
    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = self.label5.textColor = [UIColor YQcolorWithHex000000];
    [self.okBtn setBackgroundColor:[UIColor YQbtncolorHex]];
}

- (IBAction)clickBtns:(UIButton *)sender {
    if (self.addBankCellBlock) {
        self.addBankCellBlock(sender.tag);
    }
}

@end
