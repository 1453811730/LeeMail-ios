//
//  SSorderStatusV.h
//  leeMail
//
//  Created by F S on 2019/7/9.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedBtnViewBLock)(NSInteger index);
///单行连排的多个按钮
@interface SSorderStatusV : UIView
@property(nonatomic,strong) NSArray* titleArray;
@property(nonatomic,assign) NSInteger selectedINdex;

///默认颜色为darkGrayColor
@property(nonatomic,strong) UIColor* titleColor;
///默认颜色为blackColor
@property(nonatomic,strong) UIColor* titleSelectedColor;
///默认为14号字体
@property(nonatomic,strong) UIFont* titleFont;

///跟踪按钮滑动的线条的颜色
@property(nonatomic,strong) UIColor* sliderColor;
///默认为2
@property(nonatomic,assign) CGFloat sliderWidth;
///默认为15
@property(nonatomic,assign) CGFloat sliderHeigth;

///底部分割线的颜色，默认透明色
@property(nonatomic,strong) UIColor* separatoeColor;

@property(nonatomic,copy) SelectedBtnViewBLock selectedBlock;

@end

NS_ASSUME_NONNULL_END
