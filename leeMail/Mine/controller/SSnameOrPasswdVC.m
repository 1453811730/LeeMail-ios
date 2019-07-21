//
//  SSnameOrPasswdVC.m
//  leeMail
//
//  Created by F S on 2019/7/18.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSnameOrPasswdVC.h"

@interface SSnameOrPasswdVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation SSnameOrPasswdVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.comeinType == 0 ? @"修改用户名" : self.comeinType == 1 ? @"设置登录密码" : @"设置交易密码";
}

- (IBAction)clickBtn:(id)sender {
    [self.view endEditing:YES];
    if ([YQhelper isObjNil:self.inputTF.text]) {
        [self presentMessageTips:@"输入框内容不能为空！"];
        return;
    }
    
    switch (self.comeinType) {
        case 0:
            [self setUserName];
            break;
        case 1:
            [self setLoginPasswd];
            break;
        case 2:
            [self setTransactionPasswd];
            break;
            
        default:
            break;
    }
}

///修改用户名
- (void)setUserName {
    
}

///设置登录密码
- (void)setLoginPasswd {
    
}

///设置交易密码
- (void)setTransactionPasswd {
    
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
