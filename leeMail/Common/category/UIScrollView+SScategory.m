//
//  UIScrollView+SScategory.m
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import "UIScrollView+SScategory.h"
#import <MJRefresh.h>


@implementation UIScrollView (SScategory)

- (void)SS_endRefresh{
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}

- (void)SS_addRefreshHeaderWithBlock:(void (^)())reFreshBlock{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        reFreshBlock();
    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

- (void)SS_addRefreshFooterWithBlock:(void (^)())reFreshBlock{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        reFreshBlock();
    }];
}

- (void)SS_beginRefreshing{
    [self.mj_header beginRefreshing];
}

- (void)SS_footerBeginRefresh{
    [self.mj_footer beginRefreshing];
}

- (BOOL)SS_headerIsRefreshing {
    return  [self.mj_header isRefreshing];
    
}

@end
