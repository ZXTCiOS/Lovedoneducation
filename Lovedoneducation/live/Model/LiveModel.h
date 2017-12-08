//
//  LiveModel.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CourseState) {
    CourseStateBefore,
    CourseStateing,
    CourseStateAfter
};

@class LiveCourseModel, LiveTeacherModel, LiveCourseListModel;
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
@property (nonatomic, copy) NSString *c_intro;
@property (nonatomic, copy) NSString *c_qq;
@property (nonatomic, copy) NSString *c_type; // 1, mianfei  , 2 shoufei;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray<LiveTeacherModel *> *teacher;
@property (nonatomic, copy) NSString *classnum;
@property (nonatomic, copy) NSString *isbuy;  // 1, 已买, 2. 没买

// 缓存课程专用
@property (nonatomic, strong) LiveCourseListModel *course;

@end

@interface LiveMyCourseModel : NSObject

@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, strong) LiveCourseModel *classs;
@property (nonatomic, copy) NSString *testid;
@property (nonatomic, copy) NSString *mtype;
@property (nonatomic, copy) NSString *mtime;
@property (nonatomic, copy) NSString *classnum;
@property (nonatomic, strong) NSArray<LiveTeacherModel *> *teacher;
@property (nonatomic, strong) NSArray *ymdhis;

@end

@interface LiveTeacherModel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tpic;
@property (nonatomic, copy) NSString *tintro;
@property (nonatomic, copy) NSString *tsimple;
@property (nonatomic, copy) NSString *tscore;

@end


/*
 * 添加属性
 * 课程 chatroom
 * video url
 * mp3 url
 * whiteboard url
 */

@interface LiveCourseListModel : NSObject

@property (nonatomic, copy) NSString *cdid;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *cdintro;
@property (nonatomic, copy) NSString *cdimg;
@property (nonatomic, assign) CourseState isstart;  //是否已开课的状态
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *cdstart_time;
@property (nonatomic, copy) NSString *cdend_time;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *whiteboard;  // 白板地址

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


