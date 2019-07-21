//
//  SSinpuPasswordVC.h
//  leeMail
//
//  Created by F S on 2019/7/8.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSinpuPasswordVC : SSbaseVC
///YES：忘记密码；NO：注册
@property(nonatomic,assign) BOOL isForgetPasswdOrRegister;

@property(nonatomic,strong) NSString* usernameStr;
@property(nonatomic,strong) NSString* codeStr;
@property(nonatomic,strong) NSString* twoSuccKey;
@property(nonatomic,strong) NSString* inviter;



@end

NS_ASSUME_NONNULL_END
