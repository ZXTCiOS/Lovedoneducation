//
//  messagedetalModel.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messagedetalModel : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *qid;
@property (nonatomic,strong) NSMutableArray *questionintro;

@end
