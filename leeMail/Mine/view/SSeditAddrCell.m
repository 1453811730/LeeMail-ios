//
//  SSeditAddrCell.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSeditAddrCell.h"

@interface SSeditAddrCell ()

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *label5;

@end

@implementation SSeditAddrCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubV {
    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = [UIColor YQcolorWithHex000000];
    self.label5.textColor = [UIColor YQmoneyColor];
    [self.okBtn setBackgroundColor:[UIColor YQbtncolorHex]];
    
    
}

- (IBAction)clickBtns:(UIButton *)sender {
    if (self.editCellBlock) {
        self.editCellBlock(sender.tag);
    }
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.recipientTF.text = dic[@"recipients"];
    self.phoneTF.text = [NSString stringWithFormat:@"%@",dic[@"phone"]];
    self.regionTF.text = dic[@"regionName"];
    self.detailAddrTF.text = dic[@"detailed"];
}

@end
