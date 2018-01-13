//
//  realpartanalysisVC0.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//


/*!
 @header realpartanalysisVC0.h
 
 @brief 错题分析
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */

#import "BaseViewController.h"
#import "smartgroupModel.h"
@interface realpartanalysisVC0 : BaseViewController
@property (nonatomic,strong) smartgroupModel *model;

/**
 正确答案
 */
@property (nonatomic,strong) NSMutableArray *answer0;

/**
 提交的答案
 */
@property (nonatomic,strong) NSMutableArray *answer1;
@end
