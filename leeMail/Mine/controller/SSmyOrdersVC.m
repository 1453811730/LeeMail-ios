//
//  SSmyOrdersVC.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyOrdersVC.h"
#import "SSorderStatusV.h"
#import "SSmyOrderCell.h"

@interface SSmyOrdersVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) SSorderStatusV* statusV;

@property(nonatomic,strong) NSMutableArray* dataMuArr;

@end

@implementation SSmyOrdersVC
#pragma mark ----- 懒加载 ------
- (SSorderStatusV *)statusV {
    if (!_statusV) {
        _statusV = [[SSorderStatusV alloc] initWithFrame:CGRectMake(0, statusBarHeight+NaviBarHeight, ScreenWidth, 43)];
        _statusV.titleArray = @[@"全部",@"待付款",@"待发货",@"待收货"];
        _statusV.selectedINdex = self.index;;
        _statusV.titleColor = [UIColor darkGrayColor];
        _statusV.titleSelectedColor = [UIColor YQcolorWithHex000000];
        _statusV.sliderColor = [UIColor YQbtncolorHex];
        _statusV.sliderHeigth = 2;
        _statusV.sliderWidth = 15;
    }
    return _statusV;
}
- (NSMutableArray *)dataMuArr {
    if (!_dataMuArr) {
        _dataMuArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataMuArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    
    [self setSubView];
}

- (void)setSubView {
    [self.statusV setLayshadowwithRadiu:15 andShadowOffset:CGSizeMake(0, 0) andShadowCorlor:RGBA(0, 0, 0, 0.1)];
    [self.view addSubview:self.statusV];
    weakly(self);
    self.statusV.selectedBlock = ^(NSInteger index) {
        if (self.index != index) {
            weakSelf.index = index;
            weakSelf.page = 1;
            [weakSelf.dataMuArr removeAllObjects];
            [weakSelf loadData];
        }
    };
    
//    self.tableView.x = 15;
//    self.tableView.width = ScreenWidth - 15 * 2;
    self.tableView.y = statusBarHeight + NaviBarHeight + self.statusV.height;
    self.tableView.height = ScreenHeight - statusBarHeight-NaviBarHeight - self.statusV.height;
    //    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight - tabBarBottomH;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerForTableCell];
    
    [self.tableView SS_addRefreshHeaderWithBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData];
    }];
    
    [self.tableView SS_addRefreshFooterWithBlock:^{
        weakSelf.page ++;
        [weakSelf loadData];
    }];
}

- (void) registerForTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSmyOrderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSmyOrderCell class])];
}

- (void)loadData {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithCapacity:1];
    if (self.index == 0) {
        params[@"orderStatus"] = @"ToPay";
    }else if (self.index == 1) {
        params[@"orderStatus"] = @"ExpectDelivery，ToDelivery，AgentSaleIn";
    }else if (self.index == 2) {
        params[@"orderStatus"] = @"Delivery，AgentSaleSuccess，AgentSaleBack";
    }else {
        params[@"orderStatus"] = @"";
    }
    params[@"pageNum"] = @(self.page);
    params[@"pageSize"] = @(self.pageSize);
    //
    [[SShttprequest shareRequest] httpRequest:params urlString:orderListUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            NSArray* dataArr = [[responseOnject objectForDictKey:@"list"] objectForDictKey:@"data"];
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

#pragma mark ----- UITableViewDelegate --------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSmyOrderCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSmyOrderCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statusIndex = self.index;
    cell.muDic = [self.dataMuArr[indexPath.row] mutableCopy];
    
    return cell;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 209;
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
