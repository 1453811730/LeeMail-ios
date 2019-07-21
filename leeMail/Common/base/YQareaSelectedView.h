//
//  YQareaSelectedView.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/7/29.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AreaSelectedBlock)(NSDictionary* province, NSDictionary* city, NSDictionary* area);
///选择省市区
@interface YQareaSelectedView : UIView

@property (nonatomic) BOOL containCurrentLocation;
@property (nonatomic) BOOL containAll;
@property (nonatomic) NSArray *filterConditions;
///YES：表示显示两级（省市）；NO：表示显示三级(省市区)
@property(nonatomic,assign) BOOL isShowTwo;

@property(nonatomic,copy) AreaSelectedBlock areaSelectBlock;

@end
