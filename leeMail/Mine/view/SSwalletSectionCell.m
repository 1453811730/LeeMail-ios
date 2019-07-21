//
//  SSwalletSectionCell.m
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSwalletSectionCell.h"

@interface SSwalletSectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *canuserBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenxiaoBtn;

@property(nonatomic,strong) UIButton* selectedBtn;

@end

@implementation SSwalletSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBtn = self.canuserBtn;
    [self.canuserBtn setTitleColor:[UIColor YQcolorWithHex999999] forState:UIControlStateNormal];
    [self.canuserBtn setTitleColor:[UIColor YQcolorWithHexString:@"#333333"] forState:UIControlStateSelected];
    
    [self.fenxiaoBtn setTitleColor:[UIColor YQcolorWithHex999999] forState:UIControlStateNormal];
    [self.fenxiaoBtn setTitleColor:[UIColor YQcolorWithHexString:@"#333333"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickBtn:(UIButton *)sender {
    if (self.selectedBtn.tag == sender.tag) {
        sender.selected = YES;
    }else{
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.lineLabel.x = sender.x;
        self.lineLabel.width = sender.width;
    }];
    if (self.selectedBlock) {
        self.selectedBlock(sender.tag);
    }
}

@end
