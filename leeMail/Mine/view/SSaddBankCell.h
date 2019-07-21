//
//  SSaddBankCell.h
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSaddBankCellBlock)(NSInteger index);

///添加银行卡界面cell
@interface SSaddBankCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *cardHolder;
@property (weak, nonatomic) IBOutlet UITextField *bankNumTF;
@property (weak, nonatomic) IBOutlet UITextField *bankCityTF;

@property (weak, nonatomic) IBOutlet UITextField *certifiCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

///0：选择开户银行；1：保存按钮
@property(nonatomic,copy) SSaddBankCellBlock addBankCellBlock;

@end

NS_ASSUME_NONNULL_END
