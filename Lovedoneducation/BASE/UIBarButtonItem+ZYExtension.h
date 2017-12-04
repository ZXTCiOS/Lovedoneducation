//
//  UIBarButtonItem+ZYExtension.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYExtension)
+ (instancetype)itemWithNorImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
