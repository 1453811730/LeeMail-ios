//
//  SSinpuPasswordVC.m
//  leeMail
//
//  Created by F S on 2019/7/8.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSinpuPasswordVC.h"

@interface SSinpuPasswordVC ()
@property (weak, nonatomic) IBOutlet UILabel *textL;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *canSeeBtn;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end

@implementation SSinpuPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubV];
}

- (void)setSubV {
    self.textL.textColor = [UIColor YQcolorWithHexString:@"#856020" andAlpha:1];
    
    self.passwordTF.secureTextEntry = self.canSeeBtn.selected;
}

- (IBAction)isShowPasswordBtn:(id)sender {
    self.canSeeBtn.selected = !self.canSeeBtn.selected;
    self.passwordTF.secureTextEntry = self.canSeeBtn.selected;
}
- (IBAction)completeBtn:(id)sender {
    [self.view endEditing:YES];
    if ([YQhelper isObjNil:self.passwordTF.text]) {
        [self presentMessageTips:@"密码不能为空！"];
        return ;
    }
    if (self.passwordTF.text.length < 6 ) {
        [self presentMessageTips:@"密码长度为6～20位字符！"];
        return ;
    }
    if (self.isForgetPasswdOrRegister) {
        
    }else {
        [self completeRegister];
    }
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

///FIXME:完成注册
- (void)completeRegister {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithCapacity:1];
    params[@"phone"] = self.usernameStr;
    params[@"twoSuccKey"] = self.twoSuccKey;
    params[@"passwd"] = self.passwordTF.text;
    params[@"passwdQd"] = self.passwordTF.text;
    if (![YQhelper isObjNil:self.inviter]) {
        params[@"initUser"] = self.inviter;
    }
//    NSLog(@"----- para = %@",params);
    [[SShttprequest shareRequest] httpRequest:params urlString:registerUrl method:HttpRequestMethodPost showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            [[SSusermodel sharedModel] mj_setKeyValues:[responseOnject objectForDictKey:@"user"]];
            [SSusermodel saveUserInfo];
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameStr forKey:phoneNum];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
}

///FIXME:重置密码
- (void)resetPasswd {
    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameStr,@"twoSuccKey":self.twoSuccKey,@"passwd":self.passwordTF.text,@"passwdQd":self.passwordTF.text} urlString:findPasswdUrl method:HttpRequestMethodPost showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
