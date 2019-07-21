//
//  SSnameOrPasswdVC.h
//  leeMail
//
//  Created by F S on 2019/7/18.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSComeInType) {
    SSComeInTypeUserName  = 0,
    SSComeInTypeLoginPasswd,
    SSComeInTypeTransAcPasswd
};

///用户名/交易密码
@interface SSnameOrPasswdVC : SSbaseVC

@property(nonatomic) SSComeInType comeinType;

@end

NS_ASSUME_NONNULL_END
