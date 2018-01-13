//
//  myinfomessageVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

/*!
 @header myinfomessageVC.h
 
 @brief 爱唐播报
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */

#import "BaseViewController.h"

@interface myinfomessageVC : BaseViewController
//定义枚举类型
typedef enum {
    ENUM_ViewController_ActionTypeHome=0,//推送进入
    ENUM_ViewController_ActionTypePush,//其他
} ENUM_ViewController_ActionType;

@property (nonatomic,assign) NSInteger InActionType; //操作类型
@end
