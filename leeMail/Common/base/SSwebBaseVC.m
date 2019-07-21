//
//  SSwebBaseVC.m
//  leeMail
//
//  Created by F S on 2019/7/16.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSwebBaseVC.h"

@interface SSwebBaseVC ()
@property(nonatomic,strong) UIWebView* webView;
@end

@implementation SSwebBaseVC
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, statusBarHeight+NaviBarHeight, ScreenWidth, ScreenHeight-NAVIHEIGHT)];
//        _webView.scalesPageToFit = YES;
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.webView loadRequest:request];
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
