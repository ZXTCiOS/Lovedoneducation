//
//  LiveChooseKechengquanVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//
/*!
 @header LiveChooseKechengquanVC.h
 
 @brief 选择课程券页面
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */
#import "BaseViewController.h"
#import "LiveSubmitOrderVC.h"
#import "securitesModel.h"
@interface LiveChooseKechengquanVC : BaseViewController
@property (nonatomic, weak) LiveSubmitOrderVC *submitvc;
@property (nonatomic,strong) NSArray<securitesModel *> *dataSource;

@end
