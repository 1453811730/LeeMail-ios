//
//  SSaddBankVC.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSaddBankVC.h"
#import "SSaddBankCell.h"
#import "SSbankAccountVC.h"
#import "YQareaKeywindView.h"

@interface SSaddBankVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SSaddBankVC
#pragma mark ---- 懒加载 -----
- (NSMutableDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _infoDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    
    [self setSubView];
}

- (void)setSubView {
    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerForTableCell];
}

- (void) registerForTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSaddBankCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSaddBankCell class])];
}


#pragma mark ---- UITableViewDelegate -------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSaddBankCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSaddBankCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(cell) Cell = cell;
    cell.addBankCellBlock = ^(NSInteger index) {
        index == 0 ? [self selecteCity:Cell] : [self addBankCard:Cell];
    };
    
    return cell;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 304;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

///分区背景色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}
///蛋疼：ios11后更改section颜色必须加上这个方法
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

///选择开户城市
- (void)selecteCity:(SSaddBankCell*)cell {
    YQareaKeywindView* keywind = [[YQareaKeywindView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-tabBarBottomH)];
    keywind.areaView.filterConditions = [[NSUserDefaults standardUserDefaults] arrayForKey:addressAreas];
    keywind.areaView.isShowTwo = YES;
    __block typeof(keywind) wind = keywind;
    keywind.areaSelectedCopyBlock = ^(NSDictionary *province, NSDictionary *city, NSDictionary *area) {
        cell.bankCityTF.text = [NSString stringWithFormat:@"%@",city[@"name"]];
        [self.infoDic setObject:[NSString stringWithFormat:@"%@",city[@"name"]] forKey:@"cardAddress"];
        [wind dismiss];
    };
}

///添加银行卡
- (void)addBankCard:(SSaddBankCell*)cell {
    if ([YQhelper isObjNil:cell.cardHolder.text]) {
        [self presentMessageTips:@"持卡人不能为空！"];
        return;
    }
    
    if ([YQhelper isObjNil:cell.bankNumTF.text]) {
        [self presentMessageTips:@"卡号不能为空！"];
        return;
    }
    if (![YQhelper isValidBankCard:cell.bankNumTF.text]) {
        [self presentMessageTips:@"请输入有效的卡号"];
        return;
    }
    
    if ([YQhelper isObjNil:cell.bankCityTF.text]) {
        [self presentMessageTips:@"请选择开户城市！"];
        return;
    }
    
    if ([YQhelper isObjNil:cell.certifiCodeTF.text]) {
        [self presentMessageTips:@"请输入身份证号！"];
    }
    if ([YQhelper isObjNil:cell.certifiCodeTF.text]) {
        [self presentMessageTips:@"请输入有效的身份证号！"];
    }
    
    if ([YQhelper isObjNil:cell.phoneTF.text]) {
        [self presentMessageTips:@"预留手机号不能为空！"];
        return;
    }
    if (![YQhelper isValidPhoneeNumber:cell.phoneTF.text]) {
        [self presentMessageTips:@"请输入正确手机号"];
        return;
    }
    
    [self.infoDic setObject:self.phone forKey:@"phone"];
    [self.infoDic setObject:self.twoSuccKey forKey:@"twoSuccKey"];
    
    [self.infoDic setObject:cell.cardHolder.text forKey:@"cardRealName"];
    [self.infoDic setObject:cell.bankNumTF.text forKey:@"cardId"];
    [self.infoDic setObject:cell.certifiCodeTF.text forKey:@"idCard"];
    [self.infoDic setObject:cell.phoneTF.text forKey:@"cardReservePhone"];
    
    [[SShttprequest shareRequest] httpRequest:@{@"cardRealName":cell.cardHolder.text,@"cardId":cell.bankNumTF.text,@"cardAddress":@"",@"idCard":cell.certifiCodeTF.text,@"cardReservePhone":cell.phoneTF.text,@"phone":self.phone,@"twoSuccKey":self.twoSuccKey} urlString:addBankCardUrl method:HttpRequestMethodPost showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
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
