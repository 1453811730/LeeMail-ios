//
//  NSArray+HRExtention.h
//  博金贷
//
//  Created by 何发松 on 16/5/10.
//  Copyright © 2016年 HeRay  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HRExtention)
/**
 *  根据index取出数组中的数据，当index大于数组个数或者小于0时返回空字符串，避免因为index越界导致的程序crash
 *
 *  @param index 脚标
 *
 *  @return index对用的数据
 */
- (id)objectAtArrayIndex:(NSUInteger)index;

/**
 将数组元素序列化成NSData

 @return NSData数据
 */
- (NSData *)transferToData;


//数组转JSON字符串
- (NSString*)arrayToJSONString;


@end
