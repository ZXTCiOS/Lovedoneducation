//
//  UIBarButtonItem+ZYExtension.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/4.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "UIBarButtonItem+ZYExtension.h"

@implementation UIBarButtonItem (ZYExtension)
+ (instancetype)itemWithNorImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containVew = [[UIView alloc] initWithFrame:btn.bounds];
    [containVew addSubview:btn];
    return [[UIBarButtonItem alloc]initWithCustomView:containVew];
}

@end
