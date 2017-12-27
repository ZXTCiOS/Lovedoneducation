
//
//  LiveModel.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [LiveCourseModel class]
             };
}
@end

@implementation LiveCourseModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"teacher": [LiveTeacherModel class]
             };
}
@end

@implementation LiveMyCourseModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"classs": @"class"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"teacher": [LiveTeacherModel class],
             @"classs": [LiveCourseModel class],
             @"ymdhis": [NSString class]
             };
}

@end

@implementation LiveTeacherModel

@end

@implementation LiveCourseListModel

@end

@implementation LiveCourseHistoryModel

@end

@implementation LiveEvaluateModel

@end
