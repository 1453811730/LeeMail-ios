//
//  SSregisterVC.m
//  leeMail
//
//  Created by F S on 2019/7/8.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSregisterVC.h"
#import "SSinpuPasswordVC.h"
#import "TimerHelper.h"

@interface SSregisterVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *iviteTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@property(nonatomic,strong) NSString* twoSuccKey;

@end

@implementation SSregisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)setSubView {
    self.titleL.textColor = [UIColor YQcolorWithHexString:@"#856020" andAlpha:1];
    self.getCodeBtn.hidden = YES;
    self.codeTextLabel.textColor = [UIColor YQcolorWithHexString:@"#C62436" andAlpha:1];
    
    [self.codeTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventEditingChanged)];
    self.codeTextLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.codeTextLabel addGestureRecognizer:tap];
    
    NSString* str = @"已有账号？立即登录";
    self.textLabel.attributedText = [str ss_strAttriWithRange:NSMakeRange(0, str.length-1-2) andFont:12 withColor:[UIColor lightGrayColor] andRange:NSMakeRange(str.length-1-2, 2) and:12 with:[UIColor YQcolorWithHexString:@"#91856F" andAlpha:1 ]];
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
    
    [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:self.codeTextLabel];
    [[SShttprequest shareRequest] httpRequest:@{@"phoneOremail":self.usernameTF.text,@"type":@"register"} urlString:sendCodeUrl method:HttpRequestMethodGet  showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
//        NSLog(@"---response-- %@",responseOnject);
    } failtureHandler:^(id  _Nonnull error) {
//        NSLog(@"---error = %@",error);
    }];
}

///校验验证码
- (void)checkCode {
    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameTF.text,@"type":@"register"} urlString:checkCodeUrl method:HttpRequestMethodGet  showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            self.twoSuccKey = [responseOnject objectForDictKey:@"twoSuccKey"];
        }else if ([responseOnject isKindOfClass:[NSString class]]) {
            [self presentMessageTips:responseOnject];
        }
    } failtureHandler:^(id  _Nonnull error) {
        NSLog(@"---error = %@",error);
    }];
    
}

- (void)textFieldChanged:(UITextField*)textField {
    if (textField.text.length == 6) {
        
    }
}

- (IBAction)agreeAndRegister:(id)sender {
    [[SShttprequest shareRequest] httpRequest:@{@"phone":self.usernameTF.text,@"type":@"register",@"code":self.codeTF.text} urlString:checkCodeUrl method:HttpRequestMethodGet  showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            self.twoSuccKey = [responseOnject objectForDictKey:@"twoSuccKey"];
            
            SSinpuPasswordVC* password = [SSinpuPasswordVC new];
            password.isForgetPasswdOrRegister = NO;
            password.usernameStr = self.usernameTF.text;
            password.codeStr = self.codeTF.text;
            password.inviter = self.iviteTF.text ? self.iviteTF.text : @"";
            password.twoSuccKey = [NSString stringWithFormat:@"%@",[responseOnject objectForDictKey:@"twoSuccKey"] ];
            [self.navigationController pushViewController:password animated:YES];
        }else if ([responseOnject isKindOfClass:[NSString class]]) {
            [self presentMessageTips:responseOnject];
        }
    } failtureHandler:^(id  _Nonnull error) {
        NSLog(@"---error = %@",error);
    }];
    
}

- (IBAction)goToLoginView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goToprotocolView:(id)sender {
    
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
