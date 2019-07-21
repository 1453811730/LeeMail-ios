//
//  SSorderDetailHeadV.h
//  leeMail
//
//  Created by F S on 2019/7/18.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SSSelectedAddrBlock)(void);

///订单详情头部视图（126）
@interface SSorderDetailHeadV : UIView

@property(nonatomic,strong) SSSelectedAddrBlock selecteAddrBlock;

@end


NS_ASSUME_NONNULL_END
