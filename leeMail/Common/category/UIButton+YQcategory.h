//
//  UIButton+YQcategory.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YQcategory)

#pragma ---------------扩大响应区域----------------
-(void)YQsetEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
-(void)YQsetEnlargeEdge:(CGFloat) size;
@end
