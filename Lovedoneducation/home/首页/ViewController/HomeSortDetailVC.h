//
//  HomeSortDetailVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"

@interface HomeSortDetailVC : BaseViewController
@property (nonatomic, strong) NSArray<HomeChildModel *> *child;
@property (nonatomic, assign) BOOL isfufei;
@end
