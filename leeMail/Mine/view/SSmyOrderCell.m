//
//  SSmyOrderCell.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyOrderCell.h"
#import <UIImageView+WebCache.h>

@interface SSmyOrderCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation SSmyOrderCell

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
//    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    [self.bgView setLayshadowwithRadiu:15 andShadowOffset:CGSizeMake(0, 0) andShadowCorlor:[UIColor YQshadowColor]];
    self.bgView.layer.cornerRadius = 5;
    
    self.dateLabel.textColor = [UIColor YQcolorWithHex666666];
    self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor YQmoneyColor];
    
    self.bgV.backgroundColor = [UIColor YQcolorWithR:250 G:250 B:250];
    self.descriLabel.textColor = self.countLabel.textColor = [UIColor YQcolorWithHex000000];
    
    self.lineLabel.backgroundColor = [UIColor YQseparatorColor];
    self.cancelBtn.titleLabel.textColor = [UIColor YQcolorWithHex333333];
    [self.cancelBtn setlayerOfViewRadius:5 andLineWidth:1 andLineCorlor:[UIColor YQcolorWithHexCCCCCC]];
    [self.okBtn setlayerOfViewRadius:5 andLineWidth:0 andLineCorlor:nil];
}

- (IBAction)clickBtns:(UIButton *)sender {
    
}

- (void)setStatusIndex:(NSInteger)statusIndex {
    _statusIndex = statusIndex;
}

- (void)setMuDic:(NSMutableDictionary *)muDic {
    _muDic = muDic;
    self.dateLabel.text = [NSString  stringWithFormat:@"%@",muDic[@"createTime"]];
    self.statusLabel.text = [self  getStatusFromeStr:[muDic[@"status"] stringValue]];;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[muDic[@"goodsCoverImg"] stringValue]] placeholderImage:nil];
    self.descriLabel.text = [NSString stringWithFormat:@"%@",muDic[@"goodsName"]];
    self.countLabel.text = [NSString stringWithFormat:@"共%@件商品 合计：",[muDic[@"num"] stringValue]];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",muDic[@"payPrice"]];
    if ([self.okBtn.titleLabel.text isEqualToString:@"立即付款"]) {
        [self.okBtn setlayerOfViewRadius:5 andLineWidth:0 andLineCorlor:nil];
        [self.okBtn setBackgroundColor:[UIColor YQcolorWithHexString:@"#C6B078"]];
        [self.okBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        [self.okBtn setlayerOfViewRadius:5 andLineWidth:1 andLineCorlor:[UIColor YQcolorWithHexCCCCCC]];
        [self.okBtn setBackgroundColor:[UIColor whiteColor]];
        [self.okBtn setTitleColor:[UIColor YQcolorWithHex333333] forState:UIControlStateNormal];
    }
}

//    ['ToPay', 'InPay', 'ExpectDelivery', 'ToDelivery', 'Delivery', 'Complete', 'Close', 'AgentSaleIn', 'AgentSaleSuccess', 'AgentSaleBack', 'AgentSaleComplete', 'RefundIn', 'RefundComplete'],
- (NSString*)getStatusFromeStr:(NSString*)str {
    if ([str isEqualToString:@"ToPay"]) {
        [self.okBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        return @"待付款";
    }else if ([str isEqualToString:@"InPay"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"付款中";
    }else if ([str isEqualToString:@"ExpectDelivery"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"待发货";
    }else if ([str isEqualToString:@"ToDelivery"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"预发货";
    }else if ([str isEqualToString:@"Delivery"]) {
        [self.okBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        return @"待收货";
    }else if ([str isEqualToString:@"Complete"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"已完成";
    }else if ([str isEqualToString:@"Close"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"已取消";
    }else if ([str isEqualToString:@"AgentSaleIn"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"代售中";
    }else if ([str isEqualToString:@"AgentSaleSuccess"]) {
        [self.okBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        return @"代售成功";
    }else if ([str isEqualToString:@"AgentSaleBack"]) {
        [self.okBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        return @"代售回款中";
    }else if ([str isEqualToString:@"AgentSaleComplete"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"代售完成";
    }else if ([str isEqualToString:@"RefundIn"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"退款中";
    }else if ([str isEqualToString:@"RefundComplete"]) {
        [self.okBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        return @"退款完成";
    }
    
    return @"";
}


@end
