//
//  YQareaKeywindView.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/7/29.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQareaSelectedView.h"

typedef void(^AreaSelectedCopyBLock)(NSDictionary* province, NSDictionary* city, NSDictionary* area);

//////选择省市区的keywindow
@interface YQareaKeywindView : UIView
@property(nonatomic,strong) YQareaSelectedView* areaView;
@property(nonatomic,strong) NSArray* areasArray;
@property(nonatomic,copy) AreaSelectedCopyBLock areaSelectedCopyBlock;

- (void)dismiss;

@end
