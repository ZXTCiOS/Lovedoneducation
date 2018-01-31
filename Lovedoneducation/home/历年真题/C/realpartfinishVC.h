//
//  realpartfinishVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

/*!
 @header realpartfinishVC.h
 
 @brief 真题完成
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */

#import "BaseViewController.h"

@interface realpartfinishVC : UIViewController
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *answerarray0;
@property (nonatomic,strong) NSMutableArray *answerarray1;

@property (nonatomic,strong) NSMutableArray *modeldata;

/**
 题目类型
 */
@property (nonatomic,copy) NSString *typestr;

/**
 当前时间
 */
@property (nonatomic,copy) NSString *timestr;
@end
