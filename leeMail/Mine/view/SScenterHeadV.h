//
//  SScenterHeadV.h
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSCenterHeadViewBlock)(NSInteger index );

@interface SScenterHeadV : UIView

@property(nonatomic,strong) UIImageView* headImagV;
@property(nonatomic,strong) UILabel* usernameLabel;

@property(nonatomic,strong) UITextField* totalMoneyTF;

@property(nonatomic,strong) SSusermodel* userModel;

///0表示头部的点击区域；1：表示查询明细
@property(nonatomic,copy) SSCenterHeadViewBlock block;

@end

NS_ASSUME_NONNULL_END
