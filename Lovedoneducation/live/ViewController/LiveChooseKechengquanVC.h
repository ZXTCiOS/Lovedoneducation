//
//  LiveChooseKechengquanVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"
#import "LiveSubmitOrderVC.h"
#import "securitesModel.h"
@interface LiveChooseKechengquanVC : BaseViewController
@property (nonatomic, weak) LiveSubmitOrderVC *submitvc;
@property (nonatomic,strong) NSArray<securitesModel *> *dataSource;

@end
