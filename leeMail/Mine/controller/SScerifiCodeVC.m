//
//  SScerifiCodeVC.m
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SScerifiCodeVC.h"
#import "SSaddBankVC.h"

@interface SScerifiCodeVC ()
@property (weak, nonatomic) IBOutlet UILabel *getCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation SScerifiCodeVC
- (NSDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _infoDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"验证手机";
    
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
    if ([YQhelper isObjNil:self.phoneTF.text]) {
        [self presentMessageTips:@"请输入手机号！"];
        return ;
    }
    if (![YQhelper isValidPhoneeNumber:self.phoneTF.text]) {
        [self presentMessageTips:@"请输入正确手机号!"];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithCapacity:1];
    params[@"phoneOremail"] = self.phoneTF.text;
    params[@"type"] = self.isDelete ? @"checkBankDelete" : @"checkBankCard";
    
    [[SShttprequest shareRequest] httpRequest:params urlString:sendCodeUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
    
}

- (IBAction)clickBtns:(UIButton *)sender {
    if ([YQhelper isObjNil:self.codeTF.text]) {
        [self presentMessageTips:@"请输入验证码！"];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithCapacity:1];
    params[@"phone"] = self.phoneTF.text;
    params[@"type"] = self.isDelete ? @"checkBankDelete" : @"checkBankCard";
    params[@"code"] = self.codeTF.text;
    
    [[SShttprequest shareRequest] httpRequest:params urlString:checkCodeUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            if (self.isDelete) {
                [self deleteCard:[responseOnject objectForDictKey:@"twoSuccKey"]];
            }else {
                SSaddBankVC* addVC = [SSaddBankVC new];
                addVC.phone = self.phoneTF.text;
                addVC.twoSuccKey = [NSString stringWithFormat:@"%@",[responseOnject objectForDictKey:@"twoSuccKey"]];
                addVC.isAddOrEdit = self.isAddOrEdit;
                if (!self.isAddOrEdit) {
                    [addVC.infoDic addEntriesFromDictionary:self.infoDic];
                }
                [self.navigationController pushViewController:addVC animated:YES];
            }
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
//        SSaddBankVC* addVC = [SSaddBankVC new];
//        [self.navigationController pushViewController:addVC animated:YES];
}

///删除
- (void)deleteCard:(NSString*)twoSuccKey {
    [[SShttprequest shareRequest] httpRequest:@{@"bankCardId":self.bankCardId,@"phone":self.phoneTF.text,@"twoSuccKey":@""} urlString:deleteBankCard method:HttpRequestMethodGet showLoading:NO showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
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
