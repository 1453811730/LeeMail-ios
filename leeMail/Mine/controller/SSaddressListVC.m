//
//  SSaddressListVC.m
//  leeMail
//
//  Created by F S on 2019/7/12.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSaddressListVC.h"
#import "SSaddressCell.h"
#import "SSeditAddressVC.h"

@interface SSaddressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray* dataMuArr;
@end

@implementation SSaddressListVC
#pragma mark ----- 懒加载 -------
- (NSMutableArray *)dataMuArr {
    if (!_dataMuArr) {
        _dataMuArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataMuArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收货地址";
    
    [self setSubView];
}

- (void)setSubView {
    UIView* vview = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-tabBarBottomH-49, ScreenWidth, 49)];
    vview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vview];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
    label.textAlignment = NSTextAlignmentCenter;
    NSString* str = @"+ 添加收货地址";
    label.attributedText = [str ss_strAttriWithRange:NSMakeRange(0, 1) andFont:20 withColor:[UIColor YQcolorWithHex999999] andRange:NSMakeRange(1, str.length-1) and:12 with:[UIColor YQcolorWithHex999999]];
    [vview addSubview:label];
    
    UIButton* addBtn = [UIButton buttonWithType:1];
    addBtn.frame = CGRectMake(0, 0, ScreenWidth, 49);
    [vview addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    str = nil;
    
    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight - tabBarBottomH- vview.height;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerForTableCell];
    weakly(self);
    [self.tableView SS_addRefreshHeaderWithBlock:^{
        [weakSelf loadData];
    }];
}

- (void) registerForTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSaddressCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSaddressCell class])];
}

- (void)loadData {
    [[SShttprequest shareRequest] httpRequest:@{} urlString:addrLIstUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            NSArray* query = [responseOnject objectForDictKey:@"address"];
            self.dataMuArr = [query mutableCopy];
            if ([YQhelper isObjNil:query]) {
                [self presentMessageTips:@"暂无收获地址！"];
            }
            [self.tableView reloadData];
           
        }
         [self.tableView SS_endRefresh];
    } failtureHandler:^(id  _Nonnull error) {
         [self.tableView SS_endRefresh];
    }];
    
    
}

#pragma mark ----- UITableViewDelegate --------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSaddressCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSaddressCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.dataMuArr[indexPath.row];
    __block typeof(cell) Cell = cell;
    cell.addrBlock = ^(NSInteger index) {
        ///0：设为默认；1：删除； 2：编辑修改
        if (index == 2) {
            SSeditAddressVC* editVC = [SSeditAddressVC new];
            [editVC.infoDic addEntriesFromDictionary:self.dataMuArr[indexPath.row]];
            editVC.isAddOrEdit = NO;;
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (index == 1) {
            [self deleteAddr:[NSString stringWithFormat:@"%@",Cell.dic[@"id"]]];
        }else {
            [self setMoren:[NSString stringWithFormat:@"%@",Cell.dic[@"id"]]];
        }
    };
    
    return cell;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119;
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


- (void)goInToEdit:(NSInteger)index {
    
}

///按钮事件
- (void)addBtn {
    SSeditAddressVC* editVC = [SSeditAddressVC new];
    editVC.isAddOrEdit = YES;;
    [self.navigationController pushViewController:editVC animated:YES];
}

///设为默认
- (void)setMoren:(NSString*)addr_id {
    [[SShttprequest shareRequest] httpRequest:@{@"addressId":addr_id} urlString:setMorenUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            
            [self loadData];
        }
    } failtureHandler:^(id  _Nonnull error) {
        
    }];
}

///删除地址
- (void)deleteAddr:(NSString*)addr_id {
    [[SShttprequest shareRequest] httpRequest:@{@"addressId":addr_id} urlString:deleaddrUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            
            [self loadData];
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
