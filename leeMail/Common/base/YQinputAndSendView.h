//
//  YQinputAndSendView.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/12/11.
//  Copyright © 2018 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///输入框 视图
@interface YQinputAndSendView : UIView
@property(nonatomic,strong) UITextField* inputTFD;
@property(nonatomic,strong) UIButton* sendBtn;

@property(nonatomic,copy) void (^sendOrReturnClickBlock) (NSString* text);
@end

NS_ASSUME_NONNULL_END
