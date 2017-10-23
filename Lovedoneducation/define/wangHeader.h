//
//  wangHeader.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h


//屏幕 宽 高
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

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

#define userDefault [NSUserDefaults standardUserDefaults]


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
#endif /* wangHeader_h */
