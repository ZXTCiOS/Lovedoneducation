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
@property (nonatomic,strong) NSMutableArray *qcontent;
@property (nonatomic,copy) NSString *qctypeid;
@property (nonatomic,copy) NSString *qdegree;
@property (nonatomic,strong) NSMutableArray *qdes;
@property (nonatomic,copy) NSString *qerror;

@property (nonatomic,copy) NSString *qsuccess;
@property (nonatomic,copy) NSString *qtgroup;
@property (nonatomic,copy) NSString *qtid;
@property (nonatomic,copy) NSString *qtitle;
@property (nonatomic,copy) NSString *qtpath;
@property (nonatomic,copy) NSString *qtype;
@property (nonatomic,copy) NSString *successnum;
@property (nonatomic,copy) NSString *time;

@end
