//
//  YQLoadingView.h
//  yiqi
//
//  Created by 戢俊龙 on 2018/10/16.
//  Copyright © 2018 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YQLoadingViewStyle) {
    YQLoadingViewStyleLoading,                  //加载中
    YQLoadingViewStyleNetworkError,             //请求错误,可以重新请求
    YQLoadingViewStyleNoMore,                   //没有数据
    YQLoadingViewStyleSuccess,                   //刷新成功隐藏视图

};

NS_ASSUME_NONNULL_BEGIN

@interface YQLoadingView : UIView

@property(nonatomic,assign)YQLoadingViewStyle  style;
@property(nonatomic,copy)void (^requestBlock)(YQLoadingView *loadingView);

- (instancetype)initWithFrame:(CGRect)frame;

- (void)dismiss;
//- (void)setFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
