//
//  SShttprequest.m
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SShttprequest.h"
#import "SSloginVC.h"
#import "SSbaseNavigationC.h"

@interface SShttprequest ()
@property (nonatomic,strong) AFHTTPSessionManager *httpSessionManager;

@end

@implementation SShttprequest

+(SShttprequest*)shareRequest {
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

-(AFHTTPSessionManager *)httpSessionManager{
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_httpSessionManager .requestSerializer setValue:@"ios" forHTTPHeaderField:@"equipment"];
        _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain",@"text/javascript", nil];
        
        //        [_httpSessionManager.requestSerializer setValue:@"11" forHTTPHeaderField:@"authorization"];
        
        _httpSessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _httpSessionManager.requestSerializer.timeoutInterval = 20;
        //        _httpSessionManager.securityPolicy.allowInvalidCertificates = true;
        _httpSessionManager.securityPolicy.validatesDomainName = NO;
        
        
    }
    return _httpSessionManager;
}

/**
 网络请求获取相关数据
 @param parameters 参数
 @param urlString 接口地址
 @param method 请求方式
 @param pictureDatas 图片数据流
 @param name 图片名
 @param showLoading 是否显示加载提示
 @param show  是否显示失败提示
 @param handler 获取成功后回调
 */
- (void)httpRequest:(NSDictionary *)parameters urlString:(NSString *)urlString method:(HttpRequestMethod)method pictureData:(NSData *)pictureDatas name:(NSString *)name showLoading:(BOOL)showLoading showFailure:(BOOL)show successHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id error))failtureHandler {
    if (showLoading) {
        [self presentLoadinghud];
    }
    NSString* tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:token];
    
    if ([YQhelper isObjNil:tokenStr]) {
        tokenStr = @"";
    }
    if (tokenStr.length) {
        [self.httpSessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:token];
    }
    
    switch (method) {
            case HttpRequestMethodGet:
            [self GET:parameters urlString:urlString isShowFailture:show sucessHandler:handler failtureHandler:failtureHandler];
            break;
            case HttpRequestMethodPost:
            [self POST:parameters urlString:urlString isShowFailture:show sucessHandler:handler failtureHandler:failtureHandler];
            break;
            case HttpRequestMethodUPLOAD:
            [self UPLOAD:parameters urlString:urlString isShowFailture:show pictureData:pictureDatas name:name sucessHandler:handler failtureHandler:failtureHandler];
            
        default:
            break;
    }
}

- (void)httpRequest:(NSDictionary *)parameters urlString:(NSString *)urlString method:(HttpRequestMethod)method  showLoading:(BOOL)showLoading showFailure:(BOOL)show successHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id error))failtureHandler {
    if (showLoading) {
        [self presentLoadinghud];
    }
    NSString* tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:token];
    
    if ([YQhelper isObjNil:tokenStr]) {
        tokenStr = @"";
    }
    if (tokenStr.length) {
        [self.httpSessionManager.requestSerializer setValue:tokenStr forHTTPHeaderField:token];
    }
    
    switch (method) {
        case HttpRequestMethodGet:
            [self GET:parameters urlString:urlString isShowFailture:show sucessHandler:handler failtureHandler:failtureHandler];
            break;
        case HttpRequestMethodPost:
            [self POST:parameters urlString:urlString isShowFailture:show sucessHandler:handler failtureHandler:failtureHandler];
            break;
//        case HttpRequestMethodUPLOAD:
//            [self UPLOAD:parameters urlString:urlString isShowFailture:show pictureData:pictureDatas name:name sucessHandler:handler failtureHandler:failtureHandler];
            
        default:
            break;
    }
}

///FIXME: post请求
- (void)POST:(NSDictionary*)parameters urlString:(NSString*)urlString isShowFailture:(BOOL)isShowFailture sucessHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id responseOnject))failtureHander {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.httpSessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"接口返回数据----%@",responseObject);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [self dismissAllTips];
        //        });
        [self dismissAllTips];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //        if ([[responseObject objectForDictKey:@"type"] isEqualToString:@"error"]) {
        //            //            [WToast showWithText:[responseObject objectForDictKey:@"content"]];
        //            [self presentFailureTips:[responseObject objectForDictKey:@"content"]];
        //            handler([responseObject objectForDictKey:@"content"]);
        //        }else{
        //            handler([responseObject objectForDictKey:@"object"]);
        //        }
        NSLog(@"-------接口返回数据=-= %@",responseObject);
//        handler(responseObject);
        if ([[responseObject objectForDictKey:@"code"] integerValue] == 0000) {
            if ([urlString isEqualToString:loginApiUrl] || [urlString isEqualToString:registerUrl]) {
                [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"token"] forKey:token];
//                handler([self processDictionaryIsNSNull:[responseObject objectForDictKey:@"user"]]);
            }else {
                
            }
            handler([self processDictionaryIsNSNull:responseObject]);
        }else if ([[responseObject objectForDictKey:@"code"] integerValue] == 9112) {
            [self presentMessageTips:[responseObject objectForDictKey:@"msg"]];
            SSloginVC* login = [[SSloginVC alloc] initWithDone:nil];
            [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:login] animated:YES completion:nil];
        }else{
//            if (isShowFailture && ![urlString isEqualToString:refreshToken]) {
//                [self presentFailureTips:[responseObject objectForDictKey:@"msg"]];
//            }
//            if ([responseObject[@"code"] integerValue] == 1102) {
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isLogin];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[YQRongYunManager share] quitRongCloud];
//                //                YQloginVC* login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YQloginVC"];
//                YQNewLoginController* login = [[YQNewLoginController alloc] initWithDone:nil];
//                [[self getCurrentVC] presentViewController:[[YQbaseNavigationC alloc] initWithRootViewController:login] animated:YES completion:nil];
//            }
            handler([responseObject objectForDictKey:@"msg"]);
            [self presentMessageTips:[responseObject objectForDictKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dismissAllTips];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        handler(error.localizedDescription);
        if (isShowFailture) {
            [self presentMessageTips:[NSString stringWithFormat:@"%@:%ld",error.localizedDescription,(long)error.code]];
            NSLog(@"------error:%@:接口:%@",error.localizedFailureReason,urlString);
        }
        failtureHander(error);
        NSLog(@"----- error= : %@",error);
    }];
}

///FIXME:get请求
- (void)GET:(NSDictionary*)parameters urlString:(NSString*)urlString isShowFailture:(BOOL)isShowFailture sucessHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id responseOnject))failtureHander {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.httpSessionManager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
        NSLog(@"-------接口返回数据=-= %@",responseObject);
        if ([[responseObject objectForDictKey:@"code"] integerValue] == 0000) {
            handler([self processDictionaryIsNSNull:responseObject]);
            
        }else if ([[responseObject objectForDictKey:@"code"] integerValue] == 9112) {
            [self presentMessageTips:[responseObject objectForDictKey:@"msg"]];
            SSloginVC* login = [[SSloginVC alloc] initWithDone:nil];
            [[self getCurrentVC] presentViewController:[[SSbaseNavigationC alloc] initWithRootViewController:login] animated:YES completion:nil];
        }else{
//            if (isShowFailture) {
//                [self presentFailureTips:[responseObject objectForDictKey:@"msg"]];
//            }
//            if ([responseObject[@"code"] integerValue] == 1102) {
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isLogin];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[YQRongYunManager share] quitRongCloud];
//                //                YQloginVC* login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YQloginVC"];
//                //                YQloginVC* login = [YQloginVC new];
//                YQNewLoginController* login = [[YQNewLoginController alloc] initWithDone:nil];
//
//                [[self getCurrentVC] presentViewController:[[YQbaseNavigationC alloc] initWithRootViewController:login] animated:YES completion:nil];
//            }
            handler([responseObject objectForDictKey:@"msg"]);
            [self presentMessageTips:[responseObject objectForDictKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        handler(error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissAllTips];
        });
        NSLog(@"------error:%@:接口:%@",error.localizedFailureReason,urlString);
        if (isShowFailture) {
            [self presentMessageTips:[NSString stringWithFormat:@"%@:%ld",error.localizedDescription,(long)error.code]];
        }
        failtureHander(error);
    }];
}

///FIXME:上传
- (void)UPLOAD:(NSDictionary*)parameters urlString:(NSString*)urlString isShowFailture:(BOOL)isShowFailture pictureData:(NSData *)pictureDatas name:(NSString *)name sucessHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id responseOnject))failtureHander {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.httpSessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:pictureDatas name:name];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForDictKey:@"code"] integerValue] == 0) {
            handler([self processDictionaryIsNSNull:[responseObject objectForDictKey:@"data"]]);
        }else{
//            if (isShowFailture) {
//                [self presentFailureTips:[responseObject objectForDictKey:@"msg"]];
//            }
//            if ([responseObject[@"code"] integerValue] == 1102) {
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isLogin];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:token];
//                [[YQRongYunManager share] quitRongCloud];
//                //                YQloginVC* login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YQloginVC"];
//                //                YQloginVC* login = [YQloginVC new];
//                YQNewLoginController* login = [[YQNewLoginController alloc] initWithDone:nil];
//
//                [[self getCurrentVC] presentViewController:[[YQbaseNavigationC alloc] initWithRootViewController:login] animated:YES completion:nil];
//            }
            handler([responseObject objectForDictKey:@"msg"]);
        }
        [self dismissAllTips];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedFailureReason);
        NSLog(@"------error:%@:接口:%@",error.localizedFailureReason,urlString);
        [self dismissAllTips];
        failtureHander(error);
    }];
}

////FIXME:获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark 数据结果处理
- (id) processDictionaryIsNSNull:(id)obj{
    const NSString *blank = @"";
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

@end
