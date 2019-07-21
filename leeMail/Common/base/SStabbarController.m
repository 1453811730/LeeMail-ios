//
//  SStabbarController.m
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SStabbarController.h"
#import "SSbaseNavigationC.h"
#import "SShomeVC.h"
#import "SSlistVC.h"
#import "SSacitivityVC.h"
#import "SSmineVC.h"
#import "SSloginVC.h"
#import "UIImage+YQcategory.h"

@interface SStabbarController ()<UITabBarControllerDelegate>

@end

@implementation SStabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
    
    SShomeVC* home = [SShomeVC new];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage ss_imageRenderOriginalWithName:@"shouye"] selectedImage:[UIImage ss_imageRenderOriginalWithName:@"shouye_selected"]];
    home.tabBarItem = item1;
    //
    SSlistVC* list = [SSlistVC new];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"列表" image:[UIImage ss_imageRenderOriginalWithName:@"liebiao"] selectedImage:[UIImage ss_imageRenderOriginalWithName:@"liebiao_selected"]];
    list.tabBarItem = item2;
    //
    SSacitivityVC* acitivity = [SSacitivityVC new];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"活动" image:[UIImage ss_imageRenderOriginalWithName:@"huodong"] selectedImage:[UIImage ss_imageRenderOriginalWithName:@"huodong_selected"]];
    acitivity.tabBarItem = item3;
    //
    SSmineVC* mine = [SSmineVC new];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage ss_imageRenderOriginalWithName:@"wode"] selectedImage:[UIImage ss_imageRenderOriginalWithName:@"wode_selected"]];
    mine.tabBarItem = item4;
    
    //
    //    YQmyCenterVC* center = [YQmyCenterVC new];
    //    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage ss_imageRenderOriginalWithName:@"forth"] selectedImage:[UIImage ss_imageRenderOriginalWithName:@"forth_selected"]];
    //    center.tabBarItem = item5;
    //
    SSbaseNavigationC* navi1 = [[SSbaseNavigationC alloc] initWithRootViewController:home];
    navi1.view.tag = 1;
    navi1.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    [navi1.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    SSbaseNavigationC* navi2 = [[SSbaseNavigationC alloc] initWithRootViewController:list];
    navi2.view.tag = 2;
    navi2.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    [navi2.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    SSbaseNavigationC* navi3 = [[SSbaseNavigationC alloc] initWithRootViewController:acitivity];
    navi3.view.tag = 3;
    navi3.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    [navi3.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    SSbaseNavigationC* navi4 = [[SSbaseNavigationC alloc] initWithRootViewController:mine];
    //    [self.message addNotifi];
    navi4.view.tag = 4;
    navi4.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    [navi4.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    //    YQbaseNavigationC* navi5 = [[YQbaseNavigationC alloc] initWithRootViewController:center];
    //    navi5.view.tag = 5;
    //    navi5.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    //    [navi5.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    self.delegate = self;
    self.viewControllers = @[navi1,navi2,navi3,navi4];
    self.selectedIndex = 0;
    
    //    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame = CGRectMake(0.0f, 0.0f, 50.0f, 36.0f);
    //    btn.x = (ScreenWidth - btn.width)/2.0f;
    //    btn.y = (self.tabBar.height - btn.height)/2.0f;
    //    [btn setImage:[UIImage imageNamed:@"centerTab"] forState:UIControlStateNormal];
    //    btn.backgroundColor = [UIColor clearColor];
    //    [btn addTarget:self action:@selector(onCenterAdd:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.tabBar addSubview:btn];
    
    //    [self.tabBar setShadowImage:[UIImage imageNamed:@"tabbarLine"]];
    //    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarLine"]];
    [self.tabBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.2] size:CGSizeMake(ScreenWidth, 1)]];
    [self.tabBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.2] size:CGSizeMake(ScreenWidth, 1)]];
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -2);
    self.tabBar.layer.shadowOpacity = 0.2;
    
}


#pragma mark ----------- UITabBarControllerDelegate -----------------
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.title = viewController.tabBarItem.title;
}

-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    SSbaseNavigationC* navi = (SSbaseNavigationC*)viewController;
    //    if(viewController.view.tag == 1){
    //        if (tabBarController.selectedIndex == 0) {
    //            YQhomePageVC *vc = navi.viewControllers[0];
    //            [vc refreshUI];
    //        }
    //        return YES;;
    //    }
        if (viewController.view.tag >= 4 ) {
//            BOOL login = [[NSUserDefaults standardUserDefaults] boolForKey:isLogin];
//            if (login) {
//                return YES;
//            }else{
//    //            YQloginVC* login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YQloginVC"];
//                YQNewLoginController* login = [[YQNewLoginController alloc] initWithDone:nil];
//                YQbaseNavigationC* loginNavi = [[YQbaseNavigationC alloc] initWithRootViewController:login];
//                [navi.topViewController presentViewController:loginNavi animated:YES completion:nil];
//                return NO;
//            }
            if ([YQhelper isObjNil:[[NSUserDefaults standardUserDefaults] objectForKey:token]]) {
                SSloginVC* login = [SSloginVC new];
                SSbaseNavigationC* loginNavi = [[SSbaseNavigationC alloc] initWithRootViewController:login];
                [navi.topViewController presentViewController:loginNavi animated:YES completion:nil];
                
                return NO;
            }
        }
    return YES;
}

- (void)setTitlePositionAdjustment:(UIOffset)adjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR {
    
}

- (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size {
        if(!color || size.width<=0|| size.height<=0) {
        return nil;
    }
        CGRect rect = CGRectMake(0.0f,0.0f, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
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
