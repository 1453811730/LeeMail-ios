//
//  SSaddressCell.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSaddressCell.h"

@interface SSaddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *recipientL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UILabel *lineL;
@property (weak, nonatomic) IBOutlet UIButton *setMorenBtn;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation SSaddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSubV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubV {
    self.recipientL.textColor = self.phoneL.textColor = [UIColor YQcolorWithHex000000];
    self.addressL.textColor = [UIColor YQcolorWithHex666666];
    
    self.lineL.backgroundColor = [UIColor YQcolorWithHexCCCCCC];
    
    self.textLabel.textColor = [UIColor YQcolorWithHex999999];
    [self.setMorenBtn setImage:[UIImage imageNamed:@"addr_selected"] forState:UIControlStateSelected];
    [self.setMorenBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [self.setMorenBtn setlayerOfViewRadius:self.setMorenBtn.height/2 andLineWidth:2 andLineCorlor:[UIColor YQcolorWithHexCCCCCC]];
    self.deleteBtn.titleLabel.textColor = self.editBtn.titleLabel.textColor = [UIColor YQcolorWithHex666666];
    [self.deleteBtn setlayerOfViewRadius:0 andLineWidth:1 andLineCorlor:[UIColor YQcolorWithHexCCCCCC]];
    [self.editBtn setlayerOfViewRadius:0 andLineWidth:1 andLineCorlor:[UIColor YQcolorWithHexCCCCCC]];
    
}

- (IBAction)clickBtns:(UIButton *)sender {
    if (self.addrBlock) {
        self.addrBlock(sender.tag);
    }
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.recipientL.text = dic[@"recipients"];
    self.phoneL.text = [NSString stringWithFormat:@"%@",dic[@"phone"]];
    self.addressL.text = [NSString stringWithFormat:@"%@%@",dic[@"regionName"],dic[@"detailed"]];
    self.setMorenBtn.selected = [dic[@"isDefault"] boolValue];
    [self setLayerForSetBtn:[dic[@"isDefault"] boolValue]];
}

- (void)setLayerForSetBtn:(BOOL)isSelected {
    if (isSelected) {
        [self.setMorenBtn setlayerOfViewRadius:self.setMorenBtn.height/2 andLineWidth:0 andLineCorlor:nil];
    }else {
        [self.setMorenBtn setlayerOfViewRadius:self.setMorenBtn.height/2 andLineWidth:2 andLineCorlor:[UIColor YQcolorWithHexCCCCCC]];
    }
}



@end
