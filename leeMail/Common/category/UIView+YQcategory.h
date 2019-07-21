//
//  UIView+YQcategory.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef struct bottomLine {
    CGFloat left;
    CGFloat right;
    CGFloat bottom;
    CGFloat height;
}BottomLine ;

@interface UIView (YQcategory)

#pragma mark ----------- frame -----------------------
///直接获得,或者设置, View 的 x 坐标
@property(nonatomic,assign) CGFloat x;
///直接获得,或者设置, View 的 y 坐标
@property(nonatomic,assign) CGFloat y;
///直接获得一个View的宽度
@property(nonatomic,assign) CGFloat width;
///直接获得一个 View 的高度
@property(nonatomic,assign) CGFloat height;
///
@property(nonatomic,assign) CGFloat centerx;
///
@property(nonatomic,assign) CGFloat centery;

@property(nonatomic,assign) CGFloat top;
@property(nonatomic,assign) CGFloat left;

@property(nonatomic,assign) CGFloat bottom;
@property(nonatomic,assign) CGFloat right;


@property(nonatomic,assign) CGPoint origin;
@property(nonatomic,assign) CGSize size;

@property (nonatomic, readwrite,strong) NSString *identifier;


#pragma mark ----------- style -----------------------
/**
 通过贝塞尔曲线添加圆角
 @param cornerRadius 圆角大小
 */
- (void)YQaddCornerRadius:(CGFloat)cornerRadius;
/**
 通过贝塞尔曲线添加个别圆角
 @param cornerRadius 圆角大小
 @param corners 需要添加的角
 */
- (void)YQaddCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;



#pragma mark ------------ 设置上，下，左，右 的边缘线条 ---------------
///设置顶部边缘线条。bottom：表示线条的高度
@property(nonatomic,assign) UIEdgeInsets topLineInset;
///设置左侧边缘线条。right：表示线条的宽度
@property(nonatomic,assign) UIEdgeInsets leftLineInset;
///设置底部边缘线条。top：表示线条的高度
@property(nonatomic,assign) UIEdgeInsets bottomLineInset;
///设置右侧边缘线条。left：表示线条的宽度
@property(nonatomic,assign) UIEdgeInsets rightLineInset;

#pragma mark -------------  设置视图的layer层的圆角，线宽及颜色等 -----------
///设置圆角半径lineWidth==0时，表示不设置线宽
- (void)setlayerOfViewRadius:(CGFloat)cornerRadius andLineWidth:(CGFloat)lineWidth andLineCorlor:(UIColor*)lineColor;
///设置边缘阴影
- (void)setLayshadowwithRadiu:(CGFloat)radiu andShadowOffset:(CGSize)size andShadowCorlor:(UIColor*)shadowColor;

//-(void)YQsetEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
