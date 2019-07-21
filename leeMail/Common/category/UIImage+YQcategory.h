//
//  UIImage+YQcategory.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/25.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YQcategory)


///给图片添加透明度
+ (UIImage *)YQimageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *  @return UIImage
 */
+ (UIImage *)YQimageFromImage:(UIImage *)image inRect:(CGRect)rect;

/// 压缩图片尺寸 size:压缩的尺寸
- (UIImage *)imageScaleWithSize:(CGSize)size;     //此方法压缩图片有问题

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

/// 压缩图片质量
- (UIImage*)imageWithScale:(CGFloat)scale;



///显示图片本身的样子（而不是根据tintcolor显示图片颜色）
+ (UIImage *)ss_imageRenderOriginalWithName:(NSString *)name;
///图片转成base64格式
- (NSString *)ss_imageToBase64String:(CGFloat)scale;
///图片转成data
- (NSData*)ss_imageToData;

@end





