//
//  MjrefreshnormalFooter.m
//  yiqi
//
//  Created by 孙炯卿 on 2018/8/8.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import "MjrefreshnormalFooter.h"

@implementation MjrefreshnormalFooter


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
//        [self setTitle:@"" forState:MJRefreshStateIdle];
        [self setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"即将刷新" forState:MJRefreshStateWillRefresh];
        [self setTitle:@"加载中.." forState:MJRefreshStateRefreshing];
        [self setTitle:@"没有更多数据啦" forState:MJRefreshStateNoMoreData];
        //        self.state = MJRefreshStateNoMoreData;
    }
    return self;
}

//- (void)resetNoMoreData{
//    self.hidden = NO;
//    [super resetNoMoreData];
//}
//
//- (void)endRefreshingWithNoMoreData{
//    [super endRefreshingWithNoMoreData];
//    self.hidden = YES;
//}
//
//- (void)endRefreshing{
//    self.hidden = NO;
//    [super endRefreshing];
//}

- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateNoMoreData) {
            self.hidden = YES;
        }else if (state == MJRefreshStateNoMoreData) {
            self.hidden = YES;
        }else {
            self.hidden = NO;;
        }
    } else if (state == MJRefreshStatePulling) {
        self.hidden = NO;
    } else if (state == MJRefreshStateRefreshing) {
        self.hidden = NO;
    } else if (state == MJRefreshStateNoMoreData) {
        self.hidden = YES;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
