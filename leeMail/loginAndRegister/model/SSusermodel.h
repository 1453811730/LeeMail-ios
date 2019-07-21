//
//  SSusermodel.h
//  leeMail
//
//  Created by F S on 2019/7/8.
//  Copyright © 2019 F S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///登录用户数据模型
@interface SSusermodel : NSObject<NSCoding>

@property(nonatomic,strong) NSString *headImg;
@property(nonatomic,strong) NSString *idStr;
@property(nonatomic,strong) NSString *lastLoginIp;
@property(nonatomic,strong) NSString *lastLoginTime;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *setTradePassword;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *userType;


+ (id)sharedModel;
+ (void)saveUserInfo;

@end

NS_ASSUME_NONNULL_END
