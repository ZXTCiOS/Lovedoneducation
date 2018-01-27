//
//  xuHeader.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef xuHeader_h
#define xuHeader_h

#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)


#define krgb(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kSetNaviBarColor_50 [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]}]

#define kSetNaviBarColor(r, g, b, size) [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]}]

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define RootDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#define RootTemp NSTemporaryDirectory()
#define RootCache NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define MCAplicationWillTerminate @"MCAplicationWillTerminate"

#import "FileManageShare.h"
#import "FMDB.h"

#define HttpShare [HTTPSessionShare httpSessionShare]
#define DBQueueShare [DatabaseQueueShare databaseQueueShare]





#define NIMKEY @"8210a542cf018de3bb35c11282dbb23c"
#define user_accid @"test0"
#define user_imtoken @"user_imtoken"

#define TeacherBGImage @"qqq"


#define kFrameeeee if (@available(iOS 11.0, *)){\
     return CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);\
}\
else\
{\
    return CGRectMake(0, 0, kScreenW, kScreenH);\
}

/**
 * 首页
 */
#define get_shouye @"/app.php/index/index"

/**
 * 1 签到 2 分享 3 评论
 */
#define post_qiandao_fenxiang_pinglun @"/app.php/user/deport"

/**
 * 直播列表
 */
#define get_courselist @"/app.php/class/classList/"
/**
 * 课程表
 */
#define get_kechengbiao @"/app.php/class/listDetail"
/**
 * 教师历史课程
 */
#define get_teacherHistory @"/app.php/Class/teacherDetail"
/**
 * 课程评价
 */
#define get_pingjia @"/app.php/Class/comment"
/**
 * 我的课程
 */
#define get_wodekecheng @"/app.php/class/userClassList/"
/**
 * 获取 video/mp3  url
 */
#define get_videourl @"/app.php/class/getlook"


#define post_ordersucess @"/app.php/order/successOrder"



#endif /* xuHeader_h */
