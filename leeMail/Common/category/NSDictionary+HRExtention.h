//
//  NSDictionary+HRExtention.h
//  博金贷
//
//  Created by 何发松 on 16/5/9.
//  Copyright © 2016年 HeRay  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HRExtention)

/**
 根据key值取值，key没有时返回空

 @param key key值
 @return 对应的value
 */
- (id)objectForDictKey:(id)key;

/**
 字典转json

 @return json字符串
 */
- (NSString *)dictionryToJSONString;

- (NSData *)transferToData;

/**
 时间戳字典转化成时间字符串
 从字典中取time对应的时间戳，然后转化成时间字符串
 @return 时间字符串
 */
- (NSString *)dateString;


 /**
 时间戳字典转化成时间字符串
 从字典中取time对应的时间戳，然后转化成时间字符串

  @param format 时间格式化字符串
  @return 时间字符串
  */
- (NSString *)dateStringWithFormat:(NSString *)format;


/**
 删除字典中value值为空的数据

 @return <#return value description#>
 */
- (NSDictionary *)deleteEmptyValue;
@end
