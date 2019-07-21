//
//  SSusermodel.m
//  leeMail
//
//  Created by F S on 2019/7/8.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSusermodel.h"

#define UserInfoFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"userInfo.data"]

@implementation SSusermodel
//@property(nonatomic,strong) NSString *headImg;
//@property(nonatomic,strong) NSString *idStr;
//@property(nonatomic,strong) NSString *lastLoginIp;
//@property(nonatomic,strong) NSString *lastLoginTime;
//@property(nonatomic,strong) NSString *name;
//@property(nonatomic,strong) NSString *phone;
//@property(nonatomic,strong) NSString *setTradePassword;
//@property(nonatomic,strong) NSString *status;
//@property(nonatomic,strong) NSString *userType;
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.headImg = [aDecoder decodeObjectForKey:@"headImg"];
        self.idStr = [aDecoder decodeObjectForKey:@"idStr"];
        self.lastLoginIp = [aDecoder decodeObjectForKey:@"lastLoginIp"];
        self.lastLoginTime = [aDecoder decodeObjectForKey:@"lastLoginTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.setTradePassword = [aDecoder decodeObjectForKey:@"setTradePassword"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.userType = [aDecoder decodeObjectForKey:@"userType"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.headImg forKey:@"headImg"];
    [aCoder encodeObject:self.idStr forKey:@"idStr"];
    [aCoder encodeObject:self.lastLoginIp forKey:@"lastLoginIp"];
    [aCoder encodeObject:self.lastLoginTime forKey:@"lastLoginTime"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.setTradePassword forKey:@"setTradePassword"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
    
}

+ (id)sharedModel {
    static SSusermodel* user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:UserInfoFile];
        if (user == nil) {
            user = [[SSusermodel alloc] init];
        }
    });
    return user;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.idStr = value;
    }
}

+ (void)saveUserInfo {
    [NSKeyedArchiver archiveRootObject:[self sharedModel] toFile:UserInfoFile];
}

@end
