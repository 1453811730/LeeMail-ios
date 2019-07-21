//
//  SSaddressCell.h
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSaddressBlock)(NSInteger index);

///收货地址列表cell
@interface SSaddressCell : UITableViewCell

@property(nonatomic,strong) NSDictionary* dic;

@property(nonatomic,copy) SSaddressBlock addrBlock;

@end

NS_ASSUME_NONNULL_END
