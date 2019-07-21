//
//  YQbaseViewController.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/8/6.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "SSbaseViewController.h"

@interface SSbaseViewController ()

@end

@implementation SSbaseViewController
#pragma mark -------------- 懒加载 ------------
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight + NaviBarHeight, ScreenWidth, ScreenHeight - statusBarHeight - NaviBarHeight - TabBarHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor YQcolorWithR:244 G:244 B:244];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)statusBarView{
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, statusBarHeight)];
        _statusBarView.backgroundColor = [UIColor whiteColor];
    }
    return _statusBarView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor YQcolorWithR:244 G:244 B:244];
    self.page = 1;
}

- (void)setBackBarButtonItem:(UIColor*)color{
    UIBarButtonItem* back = [[UIBarButtonItem alloc] init];
    back.title = @"";
    back.tintColor = color;
    self.navigationItem.backBarButtonItem = back;
}


- (void)dealloc{
    self.tableView = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
