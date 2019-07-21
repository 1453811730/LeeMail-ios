//
//  SShttprequest.h
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
/**
 网络请求方式
 - HttpRequestMethodGet: get
 - HttpRequestMethodPost: post
 - HttpRequestMethodUPLOAD: 图片上传
 */
typedef NS_ENUM(NSUInteger, HttpRequestMethod) {
    HttpRequestMethodGet,
    HttpRequestMethodPost,
    HttpRequestMethodUPLOAD,
};
@interface SShttprequest : NSObject

+(SShttprequest*)shareRequest;

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
- (void)httpRequest:(NSDictionary *)parameters urlString:(NSString *)urlString method:(HttpRequestMethod)method pictureData:(NSData *)pictureDatas name:(NSString *)name showLoading:(BOOL)showLoading showFailure:(BOOL)show successHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id error))failtureHandler;

- (void)httpRequest:(NSDictionary *)parameters urlString:(NSString *)urlString method:(HttpRequestMethod)method  showLoading:(BOOL)showLoading showFailure:(BOOL)show successHandler:(void(^)(id responseOnject))handler failtureHandler:(void(^)(id  error))failtureHandler;


@end

NS_ASSUME_NONNULL_END
