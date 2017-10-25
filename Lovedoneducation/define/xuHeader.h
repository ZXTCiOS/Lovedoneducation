//
//  xuHeader.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef xuHeader_h
#define xuHeader_h

#define krgb(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kSetNaviBarColor_50 [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]}]

#define kSetNaviBarColor(r, g, b, size) [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]}]

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
 *
 */

/**
 *
 */

/**
 *
 */

/**
 *
 */


#endif /* xuHeader_h */
