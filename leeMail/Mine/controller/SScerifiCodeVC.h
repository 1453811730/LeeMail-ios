//
//  SScerifiCodeVC.h
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SScerifiCodeVC : SSbaseVC

///YES:表示添加；NO：表示编辑
@property(nonatomic,assign) BOOL isAddOrEdit;

@property(nonatomic,assign) BOOL isDelete;
@property(nonatomic,strong) NSString* bankCardId;

@property(nonatomic,strong) NSMutableDictionary* infoDic;

@end

NS_ASSUME_NONNULL_END
