//
//  SSmyBankKardVC.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSmyBankKardVC.h"
#import "SSmyBankCell.h"
#import "SSaddBankVC.h"
#import "SScerifiCodeVC.h"

@interface SSmyBankKardVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray* bankCardsArr;

@end

@implementation SSmyBankKardVC
#pragma mark ----- 懒加载 -------
- (NSArray *)bankCardsArr {
    if (!_bankCardsArr) {
        _bankCardsArr = [NSArray array];
    }
    return _bankCardsArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的银行卡";
    
    [self setSubView];
}

- (void)setSubView {
    UIView* vview = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-tabBarBottomH-49, ScreenWidth, 49)];
    vview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vview];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
    label.textAlignment = NSTextAlignmentCenter;
    NSString* str = @"+ 添加银行卡";
    label.attributedText = [str ss_strAttriWithRange:NSMakeRange(0, 1) andFont:20 withColor:[UIColor YQcolorWithHex999999] andRange:NSMakeRange(1, str.length-1) and:12 with:[UIColor YQcolorWithHex999999]];
    [vview addSubview:label];
    
    UIButton* addBtn = [UIButton buttonWithType:1];
    addBtn.frame = CGRectMake(0, 0, ScreenWidth, 49);
    [vview addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    str = nil;
    
    self.tableView.height = ScreenHeight - statusBarHeight - NaviBarHeight - tabBarBottomH - vview.height;
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSmyBankCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSmyBankCell class])];
}

- (void)loadData {
    [[SShttprequest shareRequest] httpRequest:@{} urlString:allBankNameUrl method:HttpRequestMethodGet showLoading:YES showFailure:YES successHandler:^(id  _Nonnull responseOnject) {
        if ([responseOnject isKindOfClass:[NSDictionary class]]) {
            id arr = [responseOnject objectForDictKey:@"bankCard"];
            if ([YQhelper isObjNil:arr]) {
                [self presentMessageTips:@"暂无银行卡！"];
            }else {
                self.bankCardsArr = arr;
            }
            [self.tableView reloadData];
            
        }
        [self.tableView SS_endRefresh];
    } failtureHandler:^(id  _Nonnull error) {
        [self.tableView SS_endRefresh];
    }];
}

#pragma mark ---- UITableViewDelegate -------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankCardsArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSmyBankCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSmyBankCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertAction* edit = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToNext:YES];
    }];
    UIAlertAction* delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delete:[[self.bankCardsArr[indexPath.row] objectForDictKey:@"id"] stringValue]];
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [YQhelper showActionSheetActions:@[edit,delete,cancel] tips:@"" message:@"" target:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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

///进入下一个界面
- (void)goToNext:(BOOL)isYes {
    SScerifiCodeVC* code = [SScerifiCodeVC new];
    code.isAddOrEdit = isYes;
    [self.navigationController pushViewController:code animated:YES];
}

- (void)delete:(NSString*)bankCardId {
    SScerifiCodeVC* code = [SScerifiCodeVC new];
    code.isDelete = YES;
    code.bankCardId = bankCardId;
    [self.navigationController pushViewController:code animated:YES];
}

///按钮事件
- (void)addBtn {
    [self goToNext:NO];
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
