//
//  SScodeLoginVC.m
//  leeMail
//
//  Created by F S on 2019/7/8.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SScodeLoginVC.h"
#import "TimerHelper.h"
#import "SSusermodel.h"
#import "SSregisterVC.h"

@interface SScodeLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UILabel *getCodeLabel;
@property(nonatomic,strong) NSString* codeStr;

@end

@implementation SScodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSubView];
}

- (void)setSubView {
    self.getCodeLabel.textColor = [UIColor YQcolorWithHexString:@"#C62436" andAlpha:1];
    self.getCodeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.getCodeLabel addGestureRecognizer:tap];
}

///获取验证码
- (void)tap:(UITapGestureRecognizer*)tap {
    if ([YQhelper isObjNil:self.usernameTF.text]) {
        [self presentMessageTips:@"请输入手机号！"];
        return ;
    }
    if (![YQhelper isValidPhoneeNumber:self.usernameTF.text]) {
        [self presentMessageTips:@"请输入正确手机号!"];
        return;
    }
    
    [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:self.getCodeLabel];
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
//- (void)checkCode {
//    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameTF.text,@"type":@"login",@"code":@""} urlString:checkCodeUrl method:HttpRequestMethodGet  showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
//        NSLog(@"-------接口返回数据=-= %@",responseOnject);
//        NSLog(@"---response-- %@",responseOnject);
//    } failtureHandler:^(id  _Nonnull error) {
//        NSLog(@"---error = %@",error);
//    }];
//}


- (IBAction)loginBtn:(id)sender {
    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameTF.text,@"code":self.codeTF.text} urlString:loginApiUrl method:HttpRequestMethodPost showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            [[SSusermodel sharedModel] mj_setKeyValues:[responseOnject objectForDictKey:@"user"]];
            [SSusermodel saveUserInfo];
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameTF.text forKey:phoneNum];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        if ([responseOnject isKindOfClass:[NSString class]]) {
            [self presentMessageTips:responseOnject];
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerBtn:(id)sender {
    SSregisterVC* registerVC = [SSregisterVC new];
    [self.navigationController pushViewController:registerVC animated:YES];
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
