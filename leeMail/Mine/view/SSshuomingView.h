//
//  SSshuomingView.h
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSshuoMingV.h"
#import "SSshuoMForVendorV.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSshuomingView : UIView

@property(nonatomic,strong) SSshuoMingV* shuoV;
@property(nonatomic,strong) SSshuoMForVendorV* shuoForVendorV;

- (void)showInWallet;

- (void)showInVendorPayment;

@end

NS_ASSUME_NONNULL_END
