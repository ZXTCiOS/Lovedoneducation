//
//  LiveSubmitOrderVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
#import "LiveCourseDetailVC.h"

@interface LiveSubmitOrderVC : BaseViewController
@property (nonatomic, weak) LiveCourseDetailVC *vc;
@property (nonatomic, strong) LiveCourseModel *model;
@property (nonatomic, copy) NSString *kechengquan;  // 课程券金额
@property (nonatomic, copy) NSString *kechengquanid;// 课程券 id

@end
