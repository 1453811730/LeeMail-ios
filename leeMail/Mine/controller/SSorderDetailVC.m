//
//  SSorderDetailVC.m
//  leeMail
//
//  Created by F S on 2019/7/15.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSorderDetailVC.h"
#import "SSorderDetailHeadV.h"
#import "SSorderDetailCell.h"
#import "SSorderDetailPriceCell.h"

@interface SSorderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) SSorderDetailHeadV* headV;

@end

@implementation SSorderDetailVC
- (SSorderDetailHeadV *)headV {
    if (!_headV) {
        _headV = [[SSorderDetailHeadV alloc] initWithFrame:CGRectMake(0, NAVIHEIGHT, ScreenWidth, 126)];
    }
    return _headV;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self setSubV];
}

- (void)setSubV {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self registerFrorTableCell];
}

- (void)registerFrorTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSorderDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSorderDetailCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSorderDetailPriceCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SSorderDetailPriceCell class])];
}


#pragma mark ------- UITableViewDelegate --------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SSorderDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSorderDetailCell class]) forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.row == 1) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.row == 2) {
        SSorderDetailPriceCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSorderDetailPriceCell class]) forIndexPath:indexPath];
        
        return cell;
    }else {
        SSorderDetailPriceCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSorderDetailPriceCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    
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
