//
//  Helper.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;
//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;
//获取今天的日期：年月日
+(NSDictionary *)getTodayDate;
//自定义 正则匹配
+ (BOOL) justWithInitRegularly:(NSString *)Regularly Str:(NSString *)str;
//邮箱
+ (BOOL) justEmail:(NSString *)email;
//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile;
//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo;
//车型
+ (BOOL) justCarType:(NSString *)CarType;
//用户名
+ (BOOL) justUserName:(NSString *)name;
//密码
+ (BOOL) justPassword:(NSString *)passWord;
//昵称
+ (BOOL) justNickname:(NSString *)nickname;
//汉字
+ (BOOL) justChineseCharacter:(NSString *)Chinese;
//网址Url
+ (BOOL) justURlSite:(NSString *)urlSite;
//IP
+ (BOOL) justIP:(NSString *)ip;
//匹配流量ID
+ (BOOL) justFromID:(NSString *)fid;

@end
