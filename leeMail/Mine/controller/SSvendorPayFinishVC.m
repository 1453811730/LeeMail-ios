//
//  SSvendorPayFinishVC.m
//  leeMail
//
//  Created by F S on 2019/7/11.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSvendorPayFinishVC.h"

@interface SSvendorPayFinishVC ()
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation SSvendorPayFinishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"厂商回款";
    
    [self.okBtn setBackgroundColor:[UIColor YQbtncolorHex]];
    [self.okBtn setlayerOfViewRadius:5 andLineWidth:0 andLineCorlor:nil];
}

- (IBAction)okBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//- (void)backBtn {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
