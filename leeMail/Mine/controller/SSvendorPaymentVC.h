//
//  SSvendorPaymentVC.h
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"

NS_ASSUME_NONNULL_BEGIN
///厂商回款界面
@interface SSvendorPaymentVC : SSbaseVC

@property(nonatomic,strong) NSString* useableMoney;
@property(nonatomic,strong) NSDictionary* cardDic;

@property(nonatomic,strong) NSString* shuoMingText;
@end

NS_ASSUME_NONNULL_END
