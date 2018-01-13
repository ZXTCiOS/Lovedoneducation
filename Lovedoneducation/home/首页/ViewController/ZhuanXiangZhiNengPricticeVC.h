//
//  ZhuanXiangZhiNengPricticeVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//
/*!
 @header ZhuanXiangZhiNengPricticeVC.h
 
 @brief 专项练习页面
 
 每一个专项练习都会进入这个 VC, 需要的参数为
 @para qiname, used to display the title of this VC
 @para qtid, 专项练习的 id, to get the detail of this VC
 
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */
#import "BaseViewController.h"

@interface ZhuanXiangZhiNengPricticeVC : BaseViewController

@property (nonatomic, copy) NSString *qtname;
@property (nonatomic, copy) NSString *qtid;

@end
