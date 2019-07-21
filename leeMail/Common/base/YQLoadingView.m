//
//  YQLoadingView.m
//  yiqi
//
//  Created by 戢俊龙 on 2018/10/16.
//  Copyright © 2018 qiyu. All rights reserved.
//

#import "YQLoadingView.h"

@interface YQLoadingView ()
{
    UILabel*            _titleLabel;
    UIButton*           _networkBtn;
    UITapGestureRecognizer*         _tap; //图片手势
}

@property(nonatomic,strong)NSMutableArray  *imagesArr;
@property(nonatomic,assign)BOOL isShowAnimation;

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation YQLoadingView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        _imagesArr = [NSMutableArray array];
        for (int i = 1; i <= 12; i++) {
            NSString *imageName = [NSString stringWithFormat:@"houziloading_0000%.02d.png", i];
            //houziloading_000001
            UIImage *image = [UIImage imageNamed:imageName];
            [_imagesArr addObject:image];
        }
        [self loadImageView];
    }
    return self;
}

- (void)setStyle:(YQLoadingViewStyle)style{
    _style = style;
    switch (_style) {
        case YQLoadingViewStyleLoading:
            self.hidden = false;
            [self refreshLoadingBackView];
            break;
        case YQLoadingViewStyleNoMore:
            self.hidden = false;
            [self refreshNoMoreBackView];
            break;
        case YQLoadingViewStyleNetworkError:
            self.hidden = false;
            [self refreshNetworkBackView];
            break;
        case YQLoadingViewStyleSuccess:
            self.hidden = true;
            break;
            
        default:
            break;
    }
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setHidden:(BOOL)hidden{
    //    if (self.alpha != hidden) return;
    if (hidden) {
        self.isShowAnimation = true;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if (self.isShowAnimation) { //如果在延迟执行的过程中 执行了self.hideen = false, 就不执行此隐藏动画
                [UIView animateWithDuration:0.2 animations:^{
                    self.alpha = 0;
                }];
            }
        });
    }else{
        self.isShowAnimation = false;
        self.alpha = 1;
    }
}

- (void)addTapWithImageView:(UIImageView *)imageView{

    if (_tap) {
        [_imageView removeGestureRecognizer:_tap];
        _tap = nil;
    }
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(requestBtnClick)];
    [_imageView addGestureRecognizer:_tap];
    _imageView.userInteractionEnabled = true;
}

//加载中
- (void)refreshLoadingBackView{
    
    [_imageView removeFromSuperview];
    _imageView = [[UIImageView alloc] initWithImage:_imagesArr[0]];
    [self addSubview:_imageView];
    _imageView.animationImages = _imagesArr;
    _imageView.animationRepeatCount = 0;
    _imageView.animationDuration = _imagesArr.count * 0.04;
    [_imageView startAnimating];
    
    _imageView.center = self.center;
    _imageView.origin = CGPointMake((self.width -_imageView.width)/2, (self.height -_imageView.height)/2);
    
    [_networkBtn setTitle:@"努力加载中..." forState:(UIControlStateNormal)];
    _networkBtn.left = 10;
    
}
//没有更多数据
- (void)refreshNoMoreBackView{
    
    [_imageView stopAnimating];
    _imageView.animationImages = nil;
    [_imageView removeFromSuperview];
    _imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"yiqihou_error"]];
    _imageView.center = self.center;
    _imageView.origin = CGPointMake((self.width -_imageView.width)/2, (self.height -_imageView.height)/2);
    [self addSubview:_imageView];
    [self addTapWithImageView:_imageView];
    
    [_networkBtn setTitle:@"暂无更多数据" forState:(UIControlStateNormal)];
    _networkBtn.frame = CGRectMake(0, _imageView.bottom, ScreenWidth, 40);
    
}
//网络加载失败
- (void)refreshNetworkBackView{
    [_imageView stopAnimating];
    _imageView.animationImages = nil;
    [_imageView removeFromSuperview];
    _imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"yiqihou_error"]];
    _imageView.center = self.center;
    _imageView.origin = CGPointMake((self.width -_imageView.width)/2, (self.height -_imageView.height)/2);
    [self addSubview:_imageView];
    [self addTapWithImageView:_imageView];

    
    [_networkBtn setTitle:@"网络出现问题啦~\n点击重新加载" forState:(UIControlStateNormal)];
    _networkBtn.frame = CGRectMake(0, _imageView.bottom, ScreenWidth, 40);
    
}
- (void)requestBtnClick{
    if (_style == YQLoadingViewStyleNoMore || _style == YQLoadingViewStyleNetworkError) {
        if (_requestBlock) {
            _requestBlock(self);
        }
    }
}

- (void)loadImageView{
    
    _imageView = [[UIImageView alloc] initWithImage:_imagesArr[0]];
    [self addSubview:_imageView];
    _imageView.animationImages = _imagesArr;
    _imageView.animationRepeatCount = 0;
    _imageView.animationDuration = _imagesArr.count * 0.04;
    [_imageView startAnimating];
    
    _imageView.center = self.center;
    _imageView.origin = CGPointMake((self.width -_imageView.width)/2, (self.height -_imageView.height)/2);
    //    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageView.bottom, ScreenWidth, 40)];
    //    _titleLabel.text = @"努力加载中...";
    //    _titleLabel.textColor = UIColor.darkGrayColor;
    //    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //    [self addSubview:_titleLabel];
    
    _networkBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _networkBtn.frame = CGRectMake(10, _imageView.bottom, ScreenWidth, 40);
    [_networkBtn setTitle:@"努力加载中..." forState:(UIControlStateNormal)];
    [_networkBtn setTitleColor:UIColor.darkGrayColor forState:(UIControlStateNormal)];
    [self addSubview:_networkBtn];
    _networkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_networkBtn addTarget:self action:@selector(requestBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"rect");
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
