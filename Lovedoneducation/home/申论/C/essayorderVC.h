//
//  essayorderVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

@interface essayorderVC : BaseViewController
@property (nonatomic,copy) NSString *pricestr;
@property (nonatomic,copy) NSString *numstr;
@property (nonatomic,copy) NSString *timestr;

@property (nonatomic,copy) NSString *mqid;
@property (nonatomic,copy) NSString *markintro;

@property (nonatomic,strong) NSMutableDictionary *para;
@end
