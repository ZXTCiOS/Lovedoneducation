//
//  HomeSortDetailVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

/*!
 @header HomeSortDetailVC.h
 
 @brief 首页课程分类详情页面
 
  This is a  collectionView, you know, its simple, nothing need to say. just simple
 
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */





#import "BaseViewController.h"
#import "HomeModel.h"

@interface HomeSortDetailVC : BaseViewController
@property (nonatomic, strong) NSArray<HomeChildModel *> *child;
@property (nonatomic, assign) BOOL isfufei;
@end
