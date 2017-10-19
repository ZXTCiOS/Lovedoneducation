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

#define BASE_URL   @"http://aimidao.tv/"

#endif /* wangHeader_h */
