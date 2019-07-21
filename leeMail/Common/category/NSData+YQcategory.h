//
//  NSData+YQcategory.h
//  yiqi
//
//  Created by 孙炯卿 on 2018/6/27.
//  Copyright © 2018年 qiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YQcategory)

#pragma ------------base64--------------
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end
