//
//  YQinputAndSendView.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/12/11.
//  Copyright © 2018 qiyu. All rights reserved.
//

#import "YQinputAndSendView.h"
#import <Masonry.h>

@interface YQinputAndSendView ()<UITextFieldDelegate>

@end

@implementation YQinputAndSendView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:248 green:248 blue:248 alpha:0.5];
        self.sendBtn = [UIButton buttonWithType:1];
        [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        self.sendBtn.titleLabel.font = [UIFont YQfont14];
        [self addSubview:self.sendBtn];
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(56, 30));
        }];
        [self setBtnColor:@""];
        [self.sendBtn setlayerOfViewRadius:4 andLineWidth:0 andLineCorlor:nil];
        [self.sendBtn addTarget:self action:@selector(clickToSend) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* bgview = [UIView new];
        bgview.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgview];
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.sendBtn.mas_left).mas_equalTo(-19);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(34);
        }];
        [bgview setlayerOfViewRadius:17 andLineWidth:0.5 andLineCorlor:[UIColor YQborderColor]];
        
        self.inputTFD = [[UITextField alloc] init];
        self.inputTFD.font = [UIFont YQfont14];
        self.inputTFD.textColor = [UIColor YQtitleColor51];
        self.inputTFD.returnKeyType = UIReturnKeyDefault;
        [bgview addSubview:self.inputTFD];
        [self.inputTFD mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgview.mas_centerY);
            make.right.mas_equalTo(-17);
            make.left.mas_equalTo(17);
            make.height.mas_equalTo(34);
        }];
        self.inputTFD.delegate = self;
        [self.inputTFD addTarget:self action:@selector(textDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return self;
}

- (void)setBtnColor:(NSString*)text{
    [self.sendBtn setBackgroundColor:[YQhelper isObjNil:text] ? [UIColor YQcolorWithR:234 G:235 B:237] : [UIColor YQredColor]];
    [self.sendBtn setTitleColor:[YQhelper isObjNil:text] ? [UIColor YQcolorWithR:178 G:178 B:178] : [UIColor whiteColor] forState:UIControlStateNormal];
    self.sendBtn.userInteractionEnabled = ![YQhelper isObjNil:text] ;
}

- (void)clickToSend{
    if (self.sendOrReturnClickBlock) {
        self.sendOrReturnClickBlock(self.inputTFD.text);
    }
}

- (void)textDidChange:(UITextField*)textField{
    [self setBtnColor:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    if (![YQhelper isObjNil:textField.text]) {
        if (self.sendOrReturnClickBlock) {
            self.sendOrReturnClickBlock(textField.text);
        }
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
