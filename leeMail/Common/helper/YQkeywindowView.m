//
//  YQkeywindowView.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/8/16.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "YQkeywindowView.h"

#define is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


@implementation YQkeywindowView{
    CGRect _beforeFrame;
    CGRect _showFrame;
    CGFloat _alpha ;
}

-(instancetype) customViewWithAlpha:(CGFloat) alp{
    if([super initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, ScreenHeight)]){
        _alpha = alp;
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
        [self addSubview:_backgroundView];
        _contentMode = UIViewContentModeCenter;
        self.tag = 999;
    }
    return self;
}
-(instancetype) customerView{
    [self customViewWithAlpha:0.65];
    return self;
}

-(void) setContentMode:(UIViewContentMode)contentMode{
    _contentMode = contentMode;
    CGSize size = CGSizeMake(_contentView.width, _contentView.height);
    CGFloat offset = is_iPhoneX ? 34 : 0;
    switch (_contentMode) {
        case UIViewContentModeBottom:
            _showFrame = CGRectMake( (self.width - size.width)/2.0f , self.height-size.height - offset, size.width, size.height + offset);
            _beforeFrame = CGRectMake( (self.width - size.width)/2.0f , self.height+size.height, size.width, size.height);
            break;
        case UIViewContentModeTop:
            _showFrame = CGRectMake( (self.width - size.width)/2.0f , 0.0f, size.width, size.height);
            _beforeFrame = CGRectMake( (self.width - size.width)/2.0f , -size.height, size.width, size.height);
            break;
        case UIViewContentModeRight:
            _showFrame = CGRectMake(self.width - size.width , 0.0f, size.width, size.height);
            _beforeFrame = CGRectMake( self.width +size.width , 0.0f, size.width, size.height);
            break;
        case UIViewContentModeCenter:
        default:
            _showFrame = CGRectMake( (self.width - size.width)/2.0f , (self.height-size.height)/2.0f, size.width, size.height);
            _beforeFrame = CGRectMake( (self.width - size.width)/2.0f , -size.height, size.width, size.height);
            break;
    }
}

-(void) show{
    [self addSubview:_contentView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _contentView.frame = _beforeFrame;
    _backgroundView.alpha = 0.0f;
    [UIView animateWithDuration:0.35f animations:^{
        _backgroundView.alpha = _alpha;
        _contentView.frame = _showFrame;
    }];
    _isShow = YES;
    
}
-(void) dismiss{
    [UIView animateWithDuration:0.35 animations:^{
        _backgroundView.alpha = 0.0f;
        _contentView.frame = _beforeFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    _isShow = NO;
}


+(YQkeywindowView*) showView:(UIView*)contentView contentMode:(UIViewContentMode)contentMode{
    YQkeywindowView* view = [[YQkeywindowView alloc] customerView];
    view.contentView = contentView;
    view.contentMode = contentMode ;
    [view show];
    return view;
    
}
+(BOOL) isShowCustomView{
    YQkeywindowView* view = [[UIApplication sharedApplication].keyWindow viewWithTag:999];
    return view != nil;
}
+(void) dismissCustomView{
    YQkeywindowView* view = [[UIApplication sharedApplication].keyWindow viewWithTag:999];
    if(view) {
        [view dismiss];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
