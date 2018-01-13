//
//  strisNull.h
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface strisNull : NSObject

/**
 判断数据是否为空

 @param string 字符串
 @return 数据是否为空
 */
+ (BOOL )isNullToString:(id)string;

/**
 获取当前时间戳

 @return 时间戳
 */
+(NSString *)getNowTimeTimestamp;
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;


+(NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
/**
 数组转json
 
 @param array 数组
 @return json字符串
 */
+ (NSString *)arrayToJSONString:(NSArray *)array;
@end
