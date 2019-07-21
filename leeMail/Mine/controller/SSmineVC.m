//
//  SSmineVC.m
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmineVC.h"
#import "SScenterNaviV.h"
#import "SScenterHeadV.h"
#import "SSstatusView.h"
#import "SSCustomTableCell.h"
#import <UIImageView+WebCache.h>
#import "SSmyBankKardVC.h"
#import "SSpersonInfoVC.h"
#import "SSmyWalletVC.h"
#import "SSmyOrdersVC.h"
#import "SSaddressListVC.h"

@interface SSmineVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) SScenterNaviV* naviView;
@property(nonatomic,strong) SScenterHeadV* centerHeadV;
@property(nonatomic,strong) UILabel* textLabel;
@property(nonatomic,strong) SSstatusView* statusV;
@property(nonatomic,strong) UIView* headView;;

@end

@implementation SSmineVC
#pragma mark ------ 懒加载 ------
- (SScenterNaviV *)naviView {
    if (!_naviView) {
        _naviView = [[SScenterNaviV alloc] initWithFrame:CGRectMake(0, statusBarHeight, ScreenWidth, 44)];
    }
    return _naviView;
}
- (SScenterHeadV *)centerHeadV {
    if (!_centerHeadV) {
        _centerHeadV = [[SScenterHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 238)];
//        _centerHeadV.backgroundColor = [UIColor blueColor];
    }
    return _centerHeadV;
}
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 238, ScreenWidth, 35)];
        _textLabel.text = @"我的订单";
        _textLabel.textColor = [UIColor YQcolorWithHex000000];
        _textLabel.font = [UIFont YQfont15];
//        _textLabel.backgroundColor = [UIColor greenColor];
    }
    return _textLabel;
}
- (SSstatusView *)statusV {
    if (!_statusV) {
        _statusV = [[SSstatusView alloc] initWithFrame:CGRectMake(0, 238+35, ScreenWidth, 75)];
    }
    return _statusV;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight+NaviBarHeight, ScreenWidth, 238 + 110)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

///FIXME:------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden == NO) {
        self.navigationController.navigationBar.hidden = YES;
    }
    if ([YQhelper isObjNil:[[NSUserDefaults standardUserDefaults] arrayForKey:addressAreas]]) {
        [[SShttprequest shareRequest] httpRequest:@{} urlString:selecteAddrUrl method:HttpRequestMethodGet showLoading:NO showFailure:NO successHandler:^(id  _Nonnull responseOnject) {
            if ([responseOnject isKindOfClass:[NSDictionary class]]) {
//                NSLog(@"---接口==  %@",responseOnject);
                NSMutableArray* muArr = [[responseOnject objectForDictKey:@"allRegionList"] mutableCopy];
                [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:addressAreas];
            }
        } failtureHandler:^(id  _Nonnull error) {
            
        }];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    [self setSubV];
    
}

- (void)setSubV {
    [self.view addSubview:self.statusBarView];
    [self.view addSubview:self.naviView];
    self.naviView.rightBtnV.badgeBtnBlock = ^{
        
    };
    
    [self.headView addSubview:self.centerHeadV];
    self.centerHeadV.userModel = [SSusermodel sharedModel];
    ///头部视图的点击
    weakly(self);
    self.centerHeadV.block = ^(NSInteger index) {
        if (index == 0) {
            SSpersonInfoVC* personal = [SSpersonInfoVC new];
            personal.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:personal animated:YES];
            return ;
        }
        SSmyWalletVC* wallet = [SSmyWalletVC new];
        wallet.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:wallet animated:YES];
    };
    [self.headView addSubview:self.textLabel];
    [self.headView addSubview:self.statusV];
    ///进入全部订单/待付款等状态界面
    self.statusV.orderStatusBtnBlock = ^(NSInteger index) {
        SSmyOrdersVC* myOrder = [SSmyOrdersVC new];
        myOrder.index = index;
        myOrder.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:myOrder animated:YES];
    };
    
//    self.tableView.y = statusBarHeight ;
    self.tableView.height = ScreenHeight-statusBarHeight-NaviBarHeight-TabBarHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor YQseparatorColor];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
//    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView SS_addRefreshHeaderWithBlock:^{
        [weakSelf loadData];
    }];
    
}

- (void)loadData {
    [self.tableView SS_endRefresh];
}

#pragma mark ---------UITableViewDelegate ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSCustomTableCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCustomTableCell class])];
    if (!cell) {
        cell = [[SSCustomTableCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass([SSCustomTableCell class])];
    }
    cell.textLabel.text = indexPath.row == 0 ? @"分享注册" : indexPath.row == 1 ? @"我的收获地址" : indexPath.row == 2 ? @"我的银行卡" : @"常见问题";
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"邀请码：qwer";
    }
    cell.textLabel.textColor = [UIColor YQcolorWithHex000000];
    cell.detailTextLabel.textColor = [UIColor YQcolorWithHex999999];
    
    
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SSbaseVC* vc = nil;
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            vc = [SSaddressListVC new];
            break;
        case 2:
            vc = [SSmyBankKardVC new];
            break;
        case 3:
//            vc = [SSwebBaseVC new];
            
            break;
            
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
