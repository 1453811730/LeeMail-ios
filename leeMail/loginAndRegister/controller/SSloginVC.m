//
//  SSloginVC.m
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSloginVC.h"
#import "SSregisterVC.h"
#import "SSforgetPasswVC.h"
#import "SScodeLoginVC.h"
#import "SSusermodel.h"
#import "AppDelegate.h"

@interface SSloginVC ()<UITextFieldDelegate>{
//    void (^_done)(void);
}
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *userCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property(nonatomic,copy) void (^done)(void);

@end

@implementation SSloginVC

- (instancetype)initWithDone:(void(^ _Nullable)(void))done {
    if (self = [super init]) {
        self.done = done;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.navigationController.navigationBar.hidden = YES;
    [self setsubView];
}

- (void)setsubView {
    [self.registerBtn setTitleColor:[UIColor YQcolorWithHexString:@"#91856F" andAlpha:1] forState:UIControlStateNormal];
    [self.registerBtn setlayerOfViewRadius:5 andLineWidth:1 andLineCorlor:[UIColor YQcolorWithHexString:@"#91856F" andAlpha:1]];
    
    self.usernameTF.delegate = self;
    self.passwordTF.delegate = self;
}

- (IBAction)login:(id)sender {
    if ([YQhelper isObjNil:self.usernameTF.text]) {
        [self presentMessageTips:@"用户名不能为空！"];
        return ;
    }
    if ([YQhelper isObjNil:self.passwordTF.text]) {
        [self presentMessageTips:@"密码不能为空！"];
        return ;
    }
    [self loginHttpRequest];
}

- (IBAction)forget:(id)sender {
    SSforgetPasswVC* forget = [SSforgetPasswVC new];
    [self.navigationController pushViewController:forget animated:YES];
}

- (IBAction)userCode:(id)sender {
    SScodeLoginVC* codeLogin = [SScodeLoginVC new];
    [self.navigationController pushViewController:codeLogin animated:YES];
}

- (IBAction)registerBtn:(id)sender {
    SSregisterVC* registerVC = [SSregisterVC new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)backBtn:(id)sender {
//    [APPDELEGATE showRoot];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

///登录接口
- (void)loginHttpRequest {
    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameTF.text,@"passwd":self.passwordTF.text} urlString:loginApiUrl method:HttpRequestMethodPost showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            [[SSusermodel sharedModel] mj_setKeyValues:[responseOnject objectForDictKey:@"user"]];
            [SSusermodel saveUserInfo];
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameTF.text forKey:phoneNum];
            if (self.done) {
                self.done();
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
}


#pragma mark ---- UITextfieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if ([YQhelper isObjNil:textField.text] && textField == self.usernameTF) {
//        [self presentMessageTips:@"44445555"];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameTF) {
        [self.passwordTF becomeFirstResponder];
    }else {
        if (![YQhelper isObjNil:textField.text] && ![YQhelper isObjNil:self.usernameTF.text]) {
            //登录操作
            [self loginHttpRequest];
        }
    }
    
    return YES;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    self.usernameTF.delegate = nil;
    self.passwordTF.delegate = nil;
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
