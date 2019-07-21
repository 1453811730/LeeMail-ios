//
//  YQbaseViewController.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/8/6.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSbaseViewController : UIViewController
@property(nonatomic,strong) UITableView* tableView;
///填充顶部状态栏view
@property(nonatomic,strong) UIView* statusBarView;

@property(nonatomic,assign) NSInteger page;

@property(nonatomic,strong) NSString* uid;

///导航返回箭头的颜色
- (void)setBackBarButtonItem:(UIColor*)color;
@end
