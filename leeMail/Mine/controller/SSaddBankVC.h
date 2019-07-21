//
//  SSaddBankVC.h
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"

NS_ASSUME_NONNULL_BEGIN
///添加银行卡
@interface SSaddBankVC : SSbaseVC

@property(nonatomic,strong) NSString* phone;
@property(nonatomic,strong) NSString* twoSuccKey;

@property(nonatomic,assign) BOOL isAddOrEdit;
@property(nonatomic,strong) NSMutableDictionary* infoDic;
@end

NS_ASSUME_NONNULL_END
