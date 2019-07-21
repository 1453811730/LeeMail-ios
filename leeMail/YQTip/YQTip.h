//
//  YQTip.h
//  yiqi
//
//  Created by 戢俊龙 on 2018/8/30.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQTip : UIView
/*
 * Tip：tip的text
 */
@property (nonatomic,retain,readwrite)NSString* tip;
/*
 * Tip：view的背景色
 */
@property (nonatomic,retain,readwrite)UIColor* backGroundColor;
/*
 * Tip：tip的字体颜色
 */
@property (nonatomic,retain,readwrite)UIColor* tipColor;
/*
 * Tip：tip的字体
 */
@property (nonatomic,retain,readwrite)UIFont* font;
/*
 * Tip：显示多长时间后隐藏
 */
@property (nonatomic,assign,readwrite)CGFloat delay;

/*
 * 视图显示的y坐标
 */
@property (nonatomic,assign,readwrite)CGFloat y;

/*
 * Tip：显示view
 */
- (void)show;


@end

NS_ASSUME_NONNULL_END
