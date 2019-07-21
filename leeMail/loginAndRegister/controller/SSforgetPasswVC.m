//
//  SSforgetPasswVC.m
//  leeMail
//
//  Created by F S on 2019/7/9.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSforgetPasswVC.h"
#import "TimerHelper.h"
#import "SSinpuPasswordVC.h"

@interface SSforgetPasswVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UILabel *getCodeL;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation SSforgetPasswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubView];
}

- (void)setSubView {
    self.titleLabel.textColor = [UIColor YQcolorWithHexString:@"#856020" andAlpha:1];
    self.getCodeL.textColor = [UIColor YQcolorWithHexString:@"#C62436" andAlpha:1];
    self.getCodeL.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.getCodeL addGestureRecognizer:tap];
}

///获取验证码
- (void)tap:(UITapGestureRecognizer*)tap {
    if ([YQhelper isObjNil:self.usernameTF.text]) {
        [self presentMessageTips:@"邮箱/用户名/手机号不能为空！"];
        return;
    }
    if ([YQhelper isValidPhoneeNumber:self.usernameTF.text]) {
        [self presentMessageTips:@"请输入合法的手机号等！"];
        return;
    }
    [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:self.getCodeL];
    [[SShttprequest shareRequest] httpRequest:@{@"phoneOremail":self.usernameTF.text,@"type":@"login"} urlString:sendCodeUrl method:HttpRequestMethodGet  showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            
        }
        if ([responseOnject isKindOfClass:[NSString class]]) {
            [self presentMessageTips:responseOnject];
        }
    } failtureHandler:^(id  _Nonnull error) {
        NSLog(@"---error = %@",error);
    }];
}

///校验验证码
- (void)checkCode {
    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameTF.text,@"type":@"passwdBack"} urlString:checkCodeUrl method:HttpRequestMethodGet  showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            
            SSinpuPasswordVC* password = [SSinpuPasswordVC new];
            password.isForgetPasswdOrRegister = YES;
            password.usernameStr = self.usernameTF.text;
            password.codeStr = self.codeTF.text;
            password.twoSuccKey = [responseOnject objectForDictKey:@"twoSuccKey"];
            [self.navigationController pushViewController:password animated:YES];
        }else if ([responseOnject isKindOfClass:[NSString class]]) {
            [self presentMessageTips:responseOnject];
        }
    } failtureHandler:^(id  _Nonnull error) {
        NSLog(@"---error = %@",error);
    }];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtn:(id)sender {
    if ([YQhelper isObjNil:self.codeTF.text]) {
        [self presentMessageTips:@"请输入验证码！"];
        return;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
