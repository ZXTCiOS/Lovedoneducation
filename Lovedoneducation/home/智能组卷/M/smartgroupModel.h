//
//  smartgroupModel.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface smartgroupModel : NSObject
@property (nonatomic,copy) NSString *qid;
@property (nonatomic,copy) NSString *accuracy;
@property (nonatomic,copy) NSString *come;
@property (nonatomic,copy) NSString *kaodian;
@property (nonatomic,copy) NSString *playnum;
@property (nonatomic,strong) NSMutableArray *qanswer;
@property (nonatomic,copy) NSString *qcid;

@end
