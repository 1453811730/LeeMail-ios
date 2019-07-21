//
//  SSacitivityVC.m
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSacitivityVC.h"
#import "SSbadgeBtnV.h"
#import "SSstatusView.h"
#import <Masonry.h>
@interface SSacitivityVC ()
@property(nonatomic,strong) SSstatusView* statusV;
@end

@implementation SSacitivityVC
- (SSstatusView *)statusV {
    if (!_statusV) {
        _statusV = [[SSstatusView alloc] initWithFrame:CGRectMake(0, 238+35, ScreenWidth, 75)];
    }
    return _statusV;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动";
    UIButton*butto =  [YQhelper createButtonWithType:0 andTitle:@"1111111111" andTitleColor:[UIColor blueColor] andSelectedtitle:nil andSelectedColor:nil andFont:[UIFont YQfont16] andBgColor:[UIColor greenColor]];
    butto.frame = CGRectMake(0, 0, 100, 40);
    [self.view addSubview:butto];
    butto.center = self.view.center;
//    butto.centerx = self.view.centerx;
//    butto.centery = self.view.centery;
//    UIView* vie = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
//    vie.backgroundColor = [UIColor whiteColor];
//    vie.clipsToBounds = YES;
//    [self.view addSubview:vie];
//    UIView* vvv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    vvv2.backgroundColor = [UIColor greenColor];
////    vvv2.clipsToBounds = YES;
//    [vie addSubview:vvv2];
    
//    SSbadgeBtnV* btnV = [[SSbadgeBtnV alloc] initWithFrame:CGRectMake(20, 100, 21, 21)];
//    btnV.imageV.image = [UIImage imageNamed:@"xiaoxi"];
//    [btnV.imageV sizeToFit];
//    [btnV.imageV YQaddCornerRadius:7];
//    btnV.badgeNum = @"22";
//    [self.view addSubview:btnV];
    [self.view addSubview:self.statusV];
    
//    SScustomBadgeButton* button = [[SScustomBadgeButton alloc] initWithFrame:CGRectMake(20, 200, 50, 50)];
//    [button setTitle:@"你好" forState:UIControlStateNormal];
//    button.badgeNumStr = @"22";
//    [self.view addSubview:button];
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
