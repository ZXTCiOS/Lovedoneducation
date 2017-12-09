//
//  wangHeader.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h

#import "strisNull.h"
#import "SDAutoLayout.h"
#import "UIScrollView+EmptyDataSet.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UILabel+ChangeLineSpaceAndWordSpace.h"
#import <IQKeyboardManager.h>
//屏幕 宽 高
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

#define WS(weakSelf) weak typeof(&*self)weakSelf = self

//屏幕宽度比
#define WIDTH_SCALE [UIScreen mainScreen].bounds.size.width / 375
//屏幕高度比
#define HEIGHT_SCALE [UIScreen mainScreen].bounds.size.height / 667

//导航栏+状态栏高度
#define NAVIGATION_HEIGHT (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) + CGRectGetHeight(self.navigationController.navigationBar.frame))
// UIScreen width.
#define  LL_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  LL_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
#define  LL_iPhoneX (LL_ScreenWidth == 375.f && LL_ScreenHeight == 812.f ? YES : NO)

// Status bar height.
#define  LL_StatusBarHeight      (LL_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  LL_NavigationBarHeight  44.f

// Tabbar height.
#define  LL_TabbarHeight         (LL_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  LL_TabbarSafeBottomMargin         (LL_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  LL_StatusBarAndNavigationBarHeight  (LL_iPhoneX ? 88.f : 64.f)

#define LL_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})



#define BASE_URL   @"http://55.irapidtech.net"

#define user_token  @"TOKEN"
#define user_uid    @"UID"
#define user_phone  @"PHONE"
#define userDefault [NSUserDefaults standardUserDefaults]
#define JIGUANG     @"ee1c88aff0f66a47758b45ae"
#define user_type   @"user_type"

/**
 考试类型接口
 */
#define GET_type  @"/app.php/tool/test"

/**
 考试类型第二页选择
 */
#define GET_type2 @"/app.php/tool/test?parentid="

/**
获取验证码
 */
#define POST_value @"/app.php/tool/verification"

/**
 注册
 */
#define POST_REGISTER @"/app.php/login/register"

/**
 登录
 */
#define POST_LOGIN @"/app.php/login/login"

/**
 我的代金劵
 */
#define GET_daijinjuan @"/app.php/user/mineCoupon/?uid=%@&token=%@"

/**
 用户信息

 */
#define GET_INFO @"/app.php/user/information?uid=%@&token=%@"

/**
 修改用户信息

 @return
 */
#define POST_CHANGEINFO @"/app.php/user/update"

/**
 我的代金劵

 @return
 */
#define GET_mineCoupon @"/app.php/user/mineCoupon/?uid=%@&token=%@"

/**
 用户消息

 @return
 */
#define GET_userMessage @"/app.php/user/userMessage?uid=%@&token=%@"

/**
 爱唐博报

 @return
 */
#define GET_slide       @"/app.php/tool/slide"
/**
 名师琅琊榜

 @return
 */
#define GET_ranking @"/app.php/tool/ranking"

/**
 课程缓存

 @return
 */
#define GET_userVideo @"/app.php/user/userVideo?uid=%@&token=%@"

/**
 意见反馈

 @return  意见反馈
 */
#define POST_proposal @"/app.php/user/proposal"

/**
 网站配置

 @return
 */
#define GET_confit @"/app.php/user/config?uid=%@&token=%@"


/**
 历年真题

 @return
 */
#define GET_realQuestion @"/app.php/tool/realQuestion?uid=%@"

/**
 忘记密码

 @return
 */
#define POST_forget @"/app.php/login/forget"

/**
 首页练习类型选择

 @return  首页练习类型选择
 */
#define GET_practice @"/app.php/questions/practice/?uid=%@&token=%@&practiceType=%@"


/**
 专项练习

 @return
 */
#define GET_practice2 @"/app.php/questions/practice/?uid=%@&token=%@&practiceType=%@&qtid=%@"


/**
 添加收藏

 @return 添加收藏
 */
#define POST_userCollection @"/app.php/user/userCollection"


/**
 真题详情

 @return 真题详情
 */
#define GET_realQuestionDetail @"/app.php/tool/realQuestionDetail?qcid=%@"

/**
 图片上传

 @return 图片上传
 */
#define GET_uploadImage @"/app.php/tool/uploadImage"

/**
 答案提交

 @return
 */
#define POST_practiceing @"/app.php/Questions/practiceing"

/**
 模拟试题

 @return
 */
#define GET_testPractice @"/app.php/Questions/testPractice?uid=%@&token=%@"

/**
 数据报告

 @return
 */
#define GET_report @"/app.php/DateReport/report/?uid=%@"

/**
 练习周报

 @return 练习周报
 */
#define GET_weekdeport @"/app.php/DateReport/weekdeport?uid=%@"

/**
 申论
 @return 申论题目接口
 */
#define GET_specialpractice @"/app.php/questions/specialpractice/?uid=%@&token=%@&qtid=%@"

/**
 收藏题目

 @return 收藏题目
 */
#define GET_userquestion  @"/app.php/user/userquestion?uid=%@&token=%@&type=%@"

/**
 收藏详情

 @return
 */
#define GET_userQuestionDetail @"/app.php/user/userQuestionDetail?uid=%@&token=%@&uqid=%@"

/**
 申论下单
 @return 申论下单
 */
#define POST_orderInsert @"/app.php/order/orderInsert"

#endif /* wangHeader_h */
