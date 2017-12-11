//
//  essaycardVC.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

@interface essaycardVC : BaseViewController
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) NSString *titlestr;
@property (nonatomic,copy) NSString *pricestr;
@property (nonatomic,copy) NSString *numstr;
@property (nonatomic,strong) NSMutableDictionary *para;
@end
