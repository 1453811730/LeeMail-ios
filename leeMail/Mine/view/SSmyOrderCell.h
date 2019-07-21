//
//  SSmyOrderCell.h
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///订单cell
@interface SSmyOrderCell : UITableViewCell

@property(nonatomic,assign) NSInteger statusIndex;
@property(nonatomic,strong) NSMutableDictionary* muDic;

@end

NS_ASSUME_NONNULL_END
