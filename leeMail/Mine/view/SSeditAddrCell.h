//
//  SSeditAddrCell.h
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSeditCellBlock)(NSInteger index);
///编辑/添加地址cell
@interface SSeditAddrCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *recipientTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *regionTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAddrTF;

@property(nonatomic,strong) NSDictionary* dic;



///0：定位；1：确定按钮；2：选择省市区
@property(nonatomic,copy) SSeditCellBlock editCellBlock;

@end

NS_ASSUME_NONNULL_END
