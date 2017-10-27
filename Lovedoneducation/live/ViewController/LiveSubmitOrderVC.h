//
//  LiveSubmitOrderVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"

@interface LiveSubmitOrderVC : BaseViewController

@property (nonatomic, strong) LiveCourseModel *model;
@property (nonatomic, copy) NSString *kechengquan;  // 课程券金额

@end
