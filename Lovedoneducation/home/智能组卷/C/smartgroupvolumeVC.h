//
//  smartgroupvolumeVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

//定义枚举类型
typedef enum {
    ENUM_ViewController_ActionType0=0,
    ENUM_ViewController_ActionType1,
    ENUM_ViewController_ActionType2
} ENUM_ViewController_ActionType;

@interface smartgroupvolumeVC : BaseViewController
@property (nonatomic,assign) NSInteger InActionType; //操作类型
@end
