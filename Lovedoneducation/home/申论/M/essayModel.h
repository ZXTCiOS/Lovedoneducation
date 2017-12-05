//
//  essayModel.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface essayModel : NSObject
@property (nonatomic,copy) NSString *areaid;
@property (nonatomic,copy) NSString *dateflag;
@property (nonatomic,copy) NSString *mqid;
@property (nonatomic,strong) NSMutableArray *mqintro;
@property (nonatomic,copy) NSString *mqtitle;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *qcid;
@property (nonatomic,copy) NSString *qtid;
@property (nonatomic,copy) NSString *qtpath;
@property (nonatomic,copy) NSString *time;

@property (nonatomic,strong) NSMutableArray *answerimgarr;
@property (nonatomic,copy) NSString *textstr;
@end
