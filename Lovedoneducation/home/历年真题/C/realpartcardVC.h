//
//  realpartcardVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

@interface realpartcardVC : BaseViewController



/**
 全部model数据
 */

@property (nonatomic,strong) NSMutableArray *modeldata;

@property (nonatomic,strong) NSMutableArray *dataSource;

/**
 选择题
 */
@property (nonatomic,strong) NSMutableArray *xuanzearr;

/**
 选择题正确答案
 */
@property (nonatomic,strong) NSMutableArray *upnoarray;

/**
 题目id
 */
//@property (nonatomic,strong) NSMutableArray *upquestion;

//字符串
//@{@"uid":uid,@"token":token,@"practiceType":practiceType,@"uptimes":uptimes,@"upno":upno,@"upquestion":upquestion,@"upyes":upyes,@"uplist":upliststr};
/**
 类型
 */

@property (nonatomic,copy) NSString *practiceType;

/**
 所用时间
 */
@property (nonatomic,copy) NSString *uptimes;


/**
 错误答案
 */
@property (nonatomic,copy) NSString *upno;

/**
 题目id
 */
@property (nonatomic,copy) NSString *upquestion;

/**
 正确答案
 */
@property (nonatomic,copy) NSString *upyes;

/**
 图片和content
 */
@property (nonatomic,copy) NSString *uplist;
@end
