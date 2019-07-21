//
//  SSvendorPaymentVC.m
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSvendorPaymentVC.h"
#import "SSvendorPaymentCell.h"
#import "SSshuomingView.h"
#import "SSvendorPayFinishVC.h"

@interface SSvendorPaymentVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SSvendorPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"厂商回款";
    [self setSubView];
}

- (void)setSubView {
    self.tableView.height = ScreenHeight - statusBarHeight-NaviBarHeight;
//    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight - tabBarBottomH;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerForTableCell];
}

- (void) registerForTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSvendorPaymentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSvendorPaymentCell class])];
}

- (void)loadData {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSvendorPaymentCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSvendorPaymentCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    weakly(self);
    __block typeof(cell) Cell = cell;
    cell.vendorCellBlock = ^(NSInteger index) {
        ///0：全部金额回款；1：说明；2：眼睛；3：获取验证码；4：确定按钮
        if (index == 1) {
            SSshuomingView* shuoming = [[SSshuomingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            shuoming.shuoForVendorV.textView.text = weakSelf.shuoMingText;
            [shuoming showInVendorPayment];
        }else if (index == 4) {
            SSvendorPayFinishVC* finish = [SSvendorPayFinishVC new];
            [weakSelf.navigationController pushViewController:finish animated:YES];
        }
        switch (index) {
            case 0:
                Cell.canBackTF.text = self.useableMoney;
                break;
            case 1:{
                SSshuomingView* shuoming = [[SSshuomingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                shuoming.shuoForVendorV.textView.text = weakSelf.shuoMingText;
                [shuoming showInVendorPayment];
            }
                break;
            case 2:
                
                break;
            case 3:
                [self getCode];
                break;
            case 4:{
                SSvendorPayFinishVC* finish = [SSvendorPayFinishVC new];
                [weakSelf.navigationController pushViewController:finish animated:YES];
            }
                break;
                
            default:
                break;
        }
       
    };
    
    return cell;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (void)getCode {
    [[SShttprequest shareRequest] httpRequest:@{@"type":@"tixian",@"phoneOremail":[[NSUserDefaults standardUserDefaults] objectForKey:phoneNum]} urlString:sendCodeUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        
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
