//
//  SSwalletSectionCell.h
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SSselectedBtnBlock)(NSInteger index);

@interface SSwalletSectionCell : UITableViewCell

@property(nonatomic,copy) SSselectedBtnBlock selectedBlock;



@end

NS_ASSUME_NONNULL_END
