//
//  UIScrollView+SScategory.h
//  leeMail
//
//  Created by F S on 2019/7/10.
//  Copyright © 2019 F S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SScategory)

- (void)SS_endRefresh;
- (void)SS_addRefreshHeaderWithBlock:(void (^)())reFreshBlock;
- (void)SS_addRefreshFooterWithBlock:(void (^)())reFreshBlock;
- (void)SS_beginRefreshing;
- (void)SS_footerBeginRefresh;
- (BOOL)SS_headerIsRefreshing;

@end

NS_ASSUME_NONNULL_END
