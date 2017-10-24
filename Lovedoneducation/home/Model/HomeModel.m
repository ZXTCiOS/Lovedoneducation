//
//  HomeModel.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [HomeDataModel class]
             };
}

@end

@implementation HomeDataModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"user": [HomeUserModel class],
             @"quetions": [HomeQuestionsModel class],
             @"slide": [HomeSlideModel class]
             };
}
@end

@implementation HomeQuestionsModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"child": [HomeChildModel class]
             };
}
@end
@implementation HomeSlideModel

@end
@implementation HomeChildModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"child": [HomeChild2Model class]
             };
}
@end
@implementation HomeChild2Model

@end
@implementation HomeUserModel

@end


















