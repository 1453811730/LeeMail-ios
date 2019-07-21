//
//  SSbankAccountVC.m
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSbankAccountVC.h"
#import "SSCustomTableCell.h"

@interface SSbankAccountVC ()<UITableViewDelegate,UITableViewDataSource>{
    void (^_done)(NSDictionary* dic);
}
@property(nonatomic,strong) NSArray* bankAccArr;

@end

@implementation SSbankAccountVC
#pragma mark --------- 懒加载 --------
- (NSArray *)bankAccArr {
    if (!_bankAccArr) {
        _bankAccArr = [NSArray array];
    }
    return _bankAccArr;
}


- (instancetype)initWithDone:(void (^)(NSDictionary * _Nonnull))done {
    if (self = [super init]) {
        _done = done;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"/开户银行";
    
    [self setSubView];
}

- (void)setSubView {
    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    [self.tableView registerClass:[SSCustomTableCell class] forCellReuseIdentifier:NSStringFromClass([SSCustomTableCell class])];
}

- (void)loadData {
    [[SShttprequest shareRequest] httpRequest:@{} urlString:allBankNameUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            self.bankAccArr = [responseOnject objectForDictKey:@"bankCards"];
            [self.tableView reloadData];
        }
         [self.tableView SS_endRefresh];
    } failtureHandler:^(id  _Nonnull error) {
         [self.tableView SS_endRefresh];
    }];
}


#pragma mark ---- UITableViewDelegate -------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankAccArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSCustomTableCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSCustomTableCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont YQfont12];
    cell.textLabel.textColor = [UIColor YQcolorWithHex000000];
    cell.textLabel.text = [self.bankAccArr[indexPath.row] objectForDictKey:@"bankName"];;
    
    return cell;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_done) {
        _done(self.bankAccArr[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42;
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
