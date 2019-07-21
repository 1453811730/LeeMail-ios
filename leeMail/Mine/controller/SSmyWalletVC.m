//
//  SSmyWalletVC.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyWalletVC.h"
#import "SSmyWalletHeadV.h"
#import "SSmyWalletCell.h"
#import "SSwalletSectionCell.h"
#import "SSvendorPaymentVC.h"
#import "SSshuomingView.h"

@interface SSmyWalletVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) SSmyWalletHeadV* headV;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableArray* dataMuArr;

@property(nonatomic,strong) NSDictionary* bankCardDic;
@property(nonatomic,strong) NSString* shuoMingText;

@end

@implementation SSmyWalletVC
#pragma mark ------- 懒加载 -----
- (SSmyWalletHeadV *)headV {
    if (!_headV) {
        _headV = [[SSmyWalletHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 260-16)];
    }
    return _headV;
}
- (NSMutableArray *)dataMuArr {
    if (!_dataMuArr) {
        _dataMuArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataMuArr;
}
- (NSDictionary *)bankCardDic {
    if (!_bankCardDic) {
        _bankCardDic = [NSDictionary dictionary];
    }
    return _bankCardDic;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的钱包";
    self.index = 0;
    [self setSubView];
}

- (void)setSubView {
    weakly(self);
//    self.tableView.x = 15;
//    self.tableView.width = ScreenWidth - 15 * 2;
    self.tableView.height = ScreenHeight-statusBarHeight-NaviBarHeight-12;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor YQseparatorColor];
    self.tableView.tableHeaderView = self.headV;
    self.headV.walletHeadBLock = ^(NSInteger index) {
        ///0：眼睛按钮；1：说明按钮；2：继续购物；3：厂商回款
        if (index == 3) {
            SSvendorPaymentVC* vendor = [SSvendorPaymentVC new];
            vendor.useableMoney = [NSString stringWithFormat:@"%.2f",[weakSelf.headV.dic[@"availableFund"] doubleValue]];
            vendor.cardDic = weakSelf.bankCardDic;
            vendor.shuoMingText = weakSelf.shuoMingText;
            [weakSelf.navigationController pushViewController:vendor animated:YES];
        }else if (index == 1) {
            SSshuomingView* shuomingV = [[SSshuomingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            [shuomingV showInWallet];
        }
        
    };
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerForTableCell];
    
    [self.tableView SS_addRefreshHeaderWithBlock:^{
        [weakSelf loadData];
    }];
}

- (void) registerForTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSwalletSectionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSwalletSectionCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSmyWalletCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSmyWalletCell class])];
}

- (void)loadData {
    [[SShttprequest shareRequest] httpRequest:@{} urlString:walletHeadUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            self.headV.dic = [responseOnject objectForDictKey:@"fund"];
            self.bankCardDic = [responseOnject objectForKey:@"bankCard"];
            self.shuoMingText = [responseOnject objectForKey:@"title"];
            [self.tableView reloadData];
        }
        [self.tableView SS_endRefresh];
    } failtureHandler:^(id  _Nonnull error) {
        [self.tableView SS_endRefresh];
    }];
    
//    [self loadCellData:self.index];
}

- (void)loadCellData:(NSInteger)index {
    if (index == 0) {
        [[SShttprequest shareRequest] httpRequest:@{@"pageNum":@(self.page),@"pageSize":@(self.pageSize)} urlString:useableListUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
            if ([responseOnject isKindOfClass:[NSDictionary class]]) {
                NSDictionary* list = responseOnject[@"list"];
                NSArray* dataArr = [list objectForDictKey:@"data"];
                if (self.page == 1) {
                    [self.dataMuArr removeAllObjects];
                }
                if ([YQhelper isObjNil:dataArr]) {
                    self.page > 1 ? self.page-- : self.page;
                    self.tableView.mj_footer.hidden = YES;
                }
                if (dataArr.count < 10) {
                    self.tableView.mj_footer.hidden = YES;
                }
                if (dataArr.count) {
                    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:obj];
                        [self.dataMuArr addObject:dic];
                        dic = nil;
                    }];
                }
                
            }
            [self.tableView reloadData];
            [self.tableView SS_endRefresh];
        } failtureHandler:^(id  _Nonnull error) {
            [self.tableView SS_endRefresh];
        }];
    }else {
        [[SShttprequest shareRequest] httpRequest:@{@"pageNum":@(self.page),@"pageSize":@(self.pageSize)} urlString:distribuListUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
            if ([responseOnject isKindOfClass:[NSDictionary class]]) {
                NSDictionary* list = responseOnject[@"list"];
                NSArray* dataArr = [list objectForDictKey:@"data"];
                if (self.page == 1) {
                    [self.dataMuArr removeAllObjects];
                }
                if ([YQhelper isObjNil:dataArr]) {
                    self.page > 1 ? self.page-- : self.page;
                    self.tableView.mj_footer.hidden = YES;
                }
                if (dataArr.count < 10) {
                    self.tableView.mj_footer.hidden = YES;
                }
                if (dataArr.count) {
                    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:obj];
                        [self.dataMuArr addObject:dic];
                        dic = nil;
                    }];
                }
                
            }
            [self.tableView reloadData];
            [self.tableView SS_endRefresh];
        } failtureHandler:^(id  _Nonnull error) {
            [self.tableView SS_endRefresh];
        }];
    }
    
}

#pragma mark ------- UITableViewDelegate ------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + self.dataMuArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SSwalletSectionCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSwalletSectionCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBlock = ^(NSInteger index) {
            if (self.index == index) {
                
            }else {
                self.index = index;
                self.page = 1;
                [self loadCellData:index];
            }
        };
        return cell;
    }
    SSmyWalletCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSmyWalletCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.index == 0) {
        cell.dic = self.dataMuArr[indexPath.row-1];
    }else {
        cell.distriDic = self.dataMuArr[indexPath.row-1];
    }
    
    return cell;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 52 : 57;
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
