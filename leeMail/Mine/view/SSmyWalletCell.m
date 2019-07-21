//
//  SSmyWalletCell.m
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyWalletCell.h"

@interface SSmyWalletCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UILabel *lineL;

@end

@implementation SSmyWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSubV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubV {
    self.backgroundColor = [UIColor clearColor];
    self.titleL.textColor = [UIColor YQcolorWithHexString:@"#333333"];
    self.dateL.textColor = self.statusL.textColor = [UIColor YQcolorWithHex999999];
    self.moneyL.textColor = [UIColor YQcolorWithHexString:@"#856020"];
    self.lineL.backgroundColor = [UIColor YQcolorWithHexString:@"#EDEDED"];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.titleL.text = [NSString stringWithFormat:@"%@",[self dicString:dic[@"operType"]]];
    self.moneyL.text = [NSString stringWithFormat:@"%@",dic[@"sum"]];
    self.dateL.text = [NSString stringWithFormat:@"%@",dic[@"updateTime"]];
    self.statusL.text = [NSString stringWithFormat:@"%@",dic[@"remark"]];
}

- (NSString*)dicString:(NSString*)str {
    if ([str isEqualToString:@"COMMISION"]) {
        return @"佣金(推荐注册)";
    }else if ([str isEqualToString:@"COMMISION_GOODS"]) {
        return @"佣金(购买商品)";
    }else if ([str isEqualToString:@"SALE"]) {
        return @"代售回款";
    }else if ([str isEqualToString:@"WITHDRAW"]) {
        return @"厂商回款";
    }else if ([str isEqualToString:@"PAY"]) {
        return @"可用资产支付";
    }else if ([str isEqualToString:@"ROYALTY_AGENT"]) {
        return @"代售商品收益返佣";
    }else {
        return @"预售商品返佣";
    }
}

- (void)setDistriDic:(NSDictionary *)distriDic {
    _distriDic = distriDic;
    self.titleL.text = [NSString stringWithFormat:@"%@（%@）",distriDic[@"realtionPhone"],[self disDicString:distriDic[@"relation"]]];
    self.moneyL.text = [NSString stringWithFormat:@"提成：¥%@",distriDic[@"royaltySum"]];
    self.dateL.text = [NSString stringWithFormat:@"%@",distriDic[@"createTime"]];
    self.statusL.text = [NSString stringWithFormat:@"消费总金额：¥%@",distriDic[@"consumeSum"]];
    
}

- (NSString*)disDicString:(NSString*)str {
    if ([str isEqualToString:@"FATHER"]) {
        return @"上级";
    }else if ([str isEqualToString:@"ONELEVLE"]) {
        return @"一级";
    }else {
        return @"二级";
    }
}

@end
