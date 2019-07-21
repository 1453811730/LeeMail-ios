//
//  SSbankAccountVC.h
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"

NS_ASSUME_NONNULL_BEGIN
///开户银行
@interface SSbankAccountVC : SSbaseVC

- (instancetype)initWithDone:(void (^)(NSDictionary* dic))done;

@end

NS_ASSUME_NONNULL_END
