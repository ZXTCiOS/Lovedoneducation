//
//  LiveKeqiankehouVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"


@interface LiveKeqiankehouVC : UIViewController

@property (nonatomic, assign) CourseState state;
@property (nonatomic, strong) LiveCourseListModel *model;
@property (nonatomic, strong) LiveCourseModel *coursemodel;

@end
