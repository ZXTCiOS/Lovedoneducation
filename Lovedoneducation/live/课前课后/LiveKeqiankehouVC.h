//
//  LiveKeqiankehouVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

/*!
 @header LiveKeqiankehouVC.h
 
 @brief 课程状态详情页面.h
 分为三种状态, 课程未开始, 课程正在进行, 课程已完成
 和下载状态: 课程已下载, 未下载, 下载中
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */

#import <UIKit/UIKit.h>
#import "LiveModel.h"


@interface LiveKeqiankehouVC : UIViewController

@property (nonatomic, assign) CourseState state;
@property (nonatomic, strong) LiveCourseListModel *model;
@property (nonatomic, strong) LiveCourseModel *coursemodel;

@end
