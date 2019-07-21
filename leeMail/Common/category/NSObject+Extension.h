//
//  NSObject+Extension.h
//  yiqi
//
//  Created by 戢俊龙 on 2018/11/15.
//  Copyright © 2018 qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)

@property (nonatomic, copy) NSString *identifier; //额外添加一个标识 类似uiview的tag

- (void)setDataWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
