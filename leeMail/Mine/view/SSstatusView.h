//
//  SSstatusView.h
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSbadgeBtnV.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSOrderStatusBtnBLock)(NSInteger index);

@interface SSstatusView : UIView
@property(nonatomic,strong) SSbadgeBtnV* firstBtnV;
@property(nonatomic,strong) SSbadgeBtnV* secondBtnV;
@property(nonatomic,strong) SSbadgeBtnV* thirdBtnV;
@property(nonatomic,strong) SSbadgeBtnV* forthBtnV;

@property(nonatomic,copy) SSOrderStatusBtnBLock orderStatusBtnBlock;

@end

NS_ASSUME_NONNULL_END
