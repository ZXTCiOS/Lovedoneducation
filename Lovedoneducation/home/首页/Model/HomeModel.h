//
//  HomeModel.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeDataModel, HomeQuestionsModel, HomeSlideModel, HomeUserModel, HomeChildModel, HomeChild2Model;
@interface HomeModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) HomeDataModel *data;

@end

@interface HomeDataModel : NSObject

@property (nonatomic, strong) NSArray<HomeQuestionsModel *> *quetions;
@property (nonatomic, strong) NSArray<HomeSlideModel *> *slide;
@property (nonatomic, strong) HomeUserModel *user;
@property (nonatomic, assign) BOOL isdeport;

@end

@interface HomeQuestionsModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *qtid;
@property (nonatomic, copy) NSString *qtname;
@property (nonatomic, strong) NSArray<HomeChildModel *> *child;

@property (nonatomic, assign) BOOL isopen;

@end

@interface HomeChildModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *qtid;
@property (nonatomic, copy) NSString *qtname;
@property (nonatomic, strong) NSArray<HomeChild2Model *> *child;
/*! 是否付费 */
@property (nonatomic, copy) NSString *ischarge;//  是否付费
@end

@interface HomeChild2Model : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *qtid;
@property (nonatomic, copy) NSString *qtname;
/*! 是否付费 */
@property (nonatomic, copy) NSString *ischarge;//  是否付费

@end

@interface HomeSlideModel : NSObject

@property (nonatomic, copy) NSString *posterid;
@property (nonatomic, copy) NSString *postername;
@property (nonatomic, copy) NSString *posterimg;
@property (nonatomic, assign) NSInteger *postertype;
@property (nonatomic, copy) NSString *posterintro;
@property (nonatomic, assign) NSInteger posterstatus;
@property (nonatomic, assign) NSInteger time;

@end

@interface HomeUserModel: NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *upic;
@property (nonatomic, copy) NSString *uphone;
@property (nonatomic, copy) NSString *third;
@property (nonatomic, copy) NSString *upwd;
@property (nonatomic, copy) NSString *utest_type;
@property (nonatomic, copy) NSString *testid;
@property (nonatomic, copy) NSString *uintro;
@property (nonatomic, copy) NSString *ustatus;
@property (nonatomic, assign) NSInteger time;

@end




