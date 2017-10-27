//
//  LiveModel.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveCourseModel, LiveTeacherModel;
@interface LiveModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSArray<LiveCourseModel *> *data;

@end

@interface LiveCourseModel : NSObject

@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *ccid;
@property (nonatomic, copy) NSString *c_name;
@property (nonatomic, copy) NSString *c_price;
@property (nonatomic, copy) NSString *c_pay_num;
@property (nonatomic, assign) NSInteger c_start_time;
@property (nonatomic, assign) NSInteger c_end_time;
@property (nonatomic, assign) NSInteger c_start_pay;
@property (nonatomic, copy) NSString *c_intro_img;
@property (nonatomic, copy) NSString *c_qq;
@property (nonatomic, copy) NSString *c_type; // 1, mianfei  , 2 shoufei;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray<LiveTeacherModel *> *teacher;
@property (nonatomic, copy) NSString *classnum;

@end

@interface LiveTeacherModel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tpic;
@property (nonatomic, copy) NSString *tintro;
@property (nonatomic, copy) NSString *tsimple;
@property (nonatomic, copy) NSString *tscore;

@end

@interface LiveCourseListModel : NSObject

@property (nonatomic, copy) NSString *cdid;
@property (nonatomic, copy) NSString *c_di;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *cdintro;
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *cdstart_time;
@property (nonatomic, copy) NSString *cdend_time;
@property (nonatomic, copy) NSString *time;

@end

@interface LiveCourseHistoryModel : NSObject

@property (nonatomic, copy) NSString *cdid;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *cdintro;
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *cdstart_time;
@property (nonatomic, copy) NSString *cdend_time;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *father;

@end



@interface LiveEvaluateModel : NSObject

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *cdid;
@property (nonatomic, copy) NSString *cscore;
@property (nonatomic, copy) NSString *ccontent;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *ctime;
@end

