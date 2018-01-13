//
//  coursescacheVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//
/*!
 @header coursescacheVC.h
 
 @brief 课程缓存页面
 下载列表, 包括所有下载状态的列表, 使用的数据库保存到本地, 以及管理,断点续传等功能,
 包括的功能, 全部开始下载, 暂停下载. 单击课程时, 如果没有开始下载(下载排队中, 默认同时下载3个)则插队开始下载, 如果是暂停同上, 如已下载完成则开始回放.
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */
#import "BaseViewController.h"

@interface coursescacheVC : BaseViewController

@end
