//
//  SSorderDetailCell.m
//  leeMail
//
//  Created by F S on 2019/7/18.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSorderDetailCell.h"
#import <UIImageView+WebCache.h>

@interface SSorderDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
///规格
@property (weak, nonatomic) IBOutlet UILabel *specificationL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UILabel *kefuL;
@property (weak, nonatomic) IBOutlet UILabel *descriL;

@end

@implementation SSorderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSubV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubV {
    self.titleL.textColor = self.priceL.textColor = self.kefuL.textColor = [UIColor YQcolorWithHex000000];
    self.specificationL.textColor = self.countL.textColor = self.descriL.textColor = [UIColor YQcolorWithHex999999];
}

- (IBAction)contactServiceBtn:(UIButton *)sender {
    
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[dic[@"goodsCoverImg"] stringValue]] placeholderImage:nil];
    self.titleL.text = [NSString stringWithFormat:@"%@",dic[@"goodsName"]];
    
    self.countL.text = [NSString stringWithFormat:@"x%@",[dic[@"num"] stringValue]];
    NSString* str = [NSString stringWithFormat:@"¥%@",[dic[@"salePrice"] stringValue]];
    self.priceL.attributedText = [str ss_stringWithRange:NSMakeRange(0, 1) andFont:[UIFont YQboldFont12] withColor:[UIColor YQcolorWithHex000000] andRange:NSMakeRange(1, str.length-1) and:[UIFont YQboldFont15] with:[UIColor YQcolorWithHex000000]];
}

@end
