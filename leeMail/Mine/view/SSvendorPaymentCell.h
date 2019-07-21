//
//  SSvendorPaymentCell.h
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSVendorCellBLock)(NSInteger index);
///厂商回款界面cell
@interface SSvendorPaymentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *canBackTF;
@property (weak, nonatomic) IBOutlet UITextField *passwdTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;


///0：全部金额回款；1：说明；2：眼睛；3：获取验证码；4：确定按钮
@property(nonatomic,copy) SSVendorCellBLock vendorCellBlock;

@end

NS_ASSUME_NONNULL_END
