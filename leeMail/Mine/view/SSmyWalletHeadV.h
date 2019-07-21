//
//  SSmyWalletHeadV.h
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSWalletHeadViewBlock)(NSInteger index);

@interface SSmyWalletHeadV : UIView
///0：眼睛按钮；1：说明按钮；2：继续购物；3：厂商回款
@property(nonatomic,copy) SSWalletHeadViewBlock walletHeadBLock;

@property(nonatomic,strong) NSDictionary* dic ;

@end

NS_ASSUME_NONNULL_END
