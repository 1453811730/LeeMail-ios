//
//  SSeditAddressVC.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSeditAddressVC.h"
#import "SSeditAddrCell.h"
#import "YQareaKeywindView.h"
#import "SSusermodel.h"

@interface SSeditAddressVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SSeditAddressVC
#pragma mark ------懒加载 -----
- (NSMutableDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _infoDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.isAddOrEdit ? @"添加收货地址" : @"编辑收货地址";
    [self.infoDic setObject:[[SSusermodel sharedModel] idStr] forKey:@"userId"];
    if (self.isAddOrEdit) {
        [self.infoDic setObject:@(NO) forKey:@"isDefault"];
    }else {
//        [self.infoDic setObject:@"" forKey:@"id"];
    }
    
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSeditAddrCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSeditAddrCell class])];
}


#pragma mark ---- UITableViewDelegate -------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSeditAddrCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSeditAddrCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.isAddOrEdit) {
        cell.dic = self.infoDic;
    }
    __block typeof(cell) Cell = cell;
    cell.editCellBlock = ^(NSInteger index) {
        ///0：定位；1：确定按钮；2：选择区域
        if (index == 2) {
            [self selecteAddr:Cell];
        }else if (index == 1) {
            [self addAddr:Cell];
        }else {
            
        }
    };
    return cell;
    
    return nil;
}

- (void)selecteAddr:(SSeditAddrCell*)cell {
    YQareaKeywindView* keywind = [[YQareaKeywindView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-tabBarBottomH)];
    keywind.areaView.filterConditions = [[NSUserDefaults standardUserDefaults] arrayForKey:addressAreas];
    __block typeof(keywind) wind = keywind;
    keywind.areaSelectedCopyBlock = ^(NSDictionary *province, NSDictionary *city, NSDictionary *area) {
        cell.regionTF.text = [NSString stringWithFormat:@"%@%@%@",province[@"name"],city[@"name"],area[@"name"]];
        [self.infoDic setObject:[NSString stringWithFormat:@"%@",area[@"id"]] forKey:@"regionId"];
        [wind dismiss];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

///添加/编辑地址
- (void)addAddr:(SSeditAddrCell*)cell {
    if ([YQhelper isObjNil:cell.recipientTF.text]) {
        [self presentMessageTips:@"收件人不能为空！"];
        return;
    }
    if ([YQhelper isObjNil:cell.phoneTF.text]) {
        [self presentMessageTips:@"联系电话不能为空！"];
        return;
    }
    if ([YQhelper isObjNil:cell.regionTF.text]) {
        [self presentMessageTips:@"请选择区域"];
        return;
    }
    if ([YQhelper isObjNil:cell.detailAddrTF.text]) {
        [self presentMessageTips:@"详细地址不能为空！"];
        return;
    }
    [self.infoDic setObject:cell.recipientTF.text forKey:@"recipients"];
    [self.infoDic setObject:cell.phoneTF.text forKey:@"phone"];
    [self.infoDic setObject:cell.detailAddrTF.text forKey:@"detailed"];
    
    [[SShttprequest shareRequest] httpRequest:self.infoDic urlString:addAddrUrl method:HttpRequestMethodPost showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            
            [self.navigationController popViewControllerAnimated:YES];
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
