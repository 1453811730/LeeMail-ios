//
//  UIView+YQcategory.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "UIView+YQcategory.h"
#import <Masonry.h>
#import <objc/runtime.h>

#define BTN_MODAL_KEY           @"identifier"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;


@implementation UIView (YQcategory)

#pragma mark ----------- frame -----------------------
-(void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height{
    return self.frame.size.height;
}

- (void)setCenterx:(CGFloat)centerx{
    CGPoint center = self.center;
    center.x = centerx;
    self.center = center;
}
- (CGFloat)centerx{
    return self.center.x;
}

- (void)setCentery:(CGFloat)centery{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
}
- (CGFloat)centery{
    return self.center.y;
}



- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

//设置唯一标识 类似tag  jjl
- (void)setIdentifier:(NSString *)identifier{
    objc_setAssociatedObject(self, BTN_MODAL_KEY, identifier, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)identifier{
    NSString *modal = objc_getAssociatedObject(self, BTN_MODAL_KEY);
    return modal;
}


#pragma mark ----------- style -----------------------
///通过贝塞尔曲线划园角
- (void)YQaddCornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
///通过贝塞尔曲线划个别位置的圆角
- (void)YQaddCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark ------------ 设置上，下，左，右 的边缘线条 ---------------
///设置底部边缘线条。bottom：表示线条的高度
- (void)setTopLineInset:(UIEdgeInsets)topLineInset{
    UILabel* line = (UILabel*)[self viewWithTag:10010];
    if (!line) {
        line = [[UILabel alloc] init];
        line.backgroundColor = [UIColor YQseparatorColor];
        line.frame = CGRectMake(topLineInset.left, topLineInset.top, self.frame.size.width- topLineInset.left- topLineInset.right, topLineInset.bottom);
        [self addSubview:line];
    }
    line.hidden = topLineInset.bottom == 0;
}
///设置左侧边缘线条。right：表示线条的宽度
- (void)setLeftLineInset:(UIEdgeInsets)leftLineInset{
    UILabel* line = (UILabel*)[self viewWithTag:10020];
    if (!line) {
        line = [[UILabel alloc] init];
        line.backgroundColor = [UIColor YQseparatorColor];
        line.frame = CGRectMake(leftLineInset.left, leftLineInset.top, leftLineInset.right, self.frame.size.height- leftLineInset.top - leftLineInset.bottom);
        [self addSubview:line];
    }
    line.hidden = leftLineInset.right == 0;
}
///设置底部边缘线条。top：表示线条的高度
- (void)setBottomInset:(UIEdgeInsets)bottomLineInset{
    UILabel* line = (UILabel*)[self viewWithTag:10030];
    if (!line) {
        line = [UILabel new];
        line.backgroundColor = [UIColor YQseparatorColor];
        line.frame = CGRectMake(bottomLineInset.left, self.frame.size.height- bottomLineInset.top- bottomLineInset.bottom, self.frame.size.width- bottomLineInset.left- bottomLineInset.right, bottomLineInset.top);
        [self addSubview:line];
    }
    line.hidden = bottomLineInset.top == 0;
}
///设置右侧边缘线条。left：表示线条的宽度
- (void)setRightLineInset:(UIEdgeInsets)rightLineInset{
    UILabel* line = (UILabel*)[self viewWithTag:10040];
    if (!line) {
        line = [[UILabel alloc] init];
        line.backgroundColor = [UIColor YQseparatorColor];
        line.frame = CGRectMake(self.frame.size.width- rightLineInset.left- rightLineInset.right, rightLineInset.top, rightLineInset.left, self.frame.size.height- rightLineInset.top- rightLineInset.bottom);
        [self addSubview:line];
    }
    line.hidden = rightLineInset.left == 0;
}


#pragma mark -------------  设置视图的layer层的圆角，线宽及颜色等 -----------
///设置圆角半径lineWidth==0时，表示不设置线宽
- (void)setlayerOfViewRadius:(CGFloat)cornerRadius andLineWidth:(CGFloat)lineWidth andLineCorlor:(UIColor*)lineColor{
    self.layer.cornerRadius = cornerRadius;
    if (lineWidth != 0) {
        self.layer.borderWidth = lineWidth;
    }
    if (lineColor) {
        self.layer.borderColor = lineColor.CGColor;
    }
    self.layer.masksToBounds = YES;
}

///设置边缘阴影
- (void)setLayshadowwithRadiu:(CGFloat)radiu andShadowOffset:(CGSize)size andShadowCorlor:(UIColor*)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = radiu;
}

-(void)YQsetEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end


















